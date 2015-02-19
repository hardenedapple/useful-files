#include <cgraph.h>
#include <gvc.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <dirent.h>
#include <libgen.h>
#include <stdlib.h>
#include <sys/stat.h>

/* set makeprg=clang -Wall -W -Werror -I/usr/include/graphviz/ -lcgraph -lgvc -g trials.c -o trials */

/*
 * Questions:
 *      What is the error reporting method of the cgraph library?
 *      Should I indicate where there were more files in the label than fitted?
 */

/* TODO:
 *      Add error checking for cgraph library functions
 *      Figure out what to do with symlinks.
 *      Add option to override the list of files to ignore on command line */


/*
 * Want to take command line arguments and remove or add to a default list of
 * directories to ignore.
 *
 * Either create the list in the main function (depending on arguments) and
 * pass it to the handle_directory function which then passes it to the
 * should_ignore function.
 *
 * Or make the should_ignore function accept a second option that adds or
 * removes options from the static list of directory names.
 *
 * Creating the list:
 *      More flexible
 *      Makes it the responsibility of the main function
 *      Have to pass more parameters to handle_directory and should_ignore
 *
 * Modifying static list:
 *      For different ignore lists in different directories must remember
 *      previous changes.
 *      If don't need to change list much, is easiest this way.
 */

/* Function to define whether I should ignore the file or not */
int should_ignore(const char* filename)
{
    size_t i, change_flag = 0;
    static char* ignores[100] = {0};
    static size_t ignore_size = 0;

    /* Make sure don't have a null pointer */
    if (filename == NULL)
    {
        fprintf(stderr, "Called should_ignore with a NULL pointer\n");
        return 1;
    }

    /* Set flag for if we're changing something */
    if (filename[0] == '-' || filename[0] == '+')
    {
        change_flag = 1;
    }

    /* Not subtracting the dirname */
    if (filename[0] != '-')
    {
        /* If the dirname is in the array, return 1 */
        for (i = 0; i < ignore_size; ++i)
        {
            if (!strcmp(filename + change_flag, ignores[i]))
            {
                return 1;
            }
        }
        /* The name isn't already in the array
         * If adding, add it and return 1
         * Otherwise return 0 */
        if (change_flag)
        {
            /* Allocate and copy the new string across */
            ignores[ignore_size] = calloc(strlen(filename), sizeof(char));
            strcpy(ignores[ignore_size++], filename + 1);
            return 1;
        }
        return 0;
    }

    /* We're subtracting a directory name from the array */
    for (i = 0; i < ignore_size; ++i)
    {
        /* Free the memory for the no longer in use name */
        if (!strcmp(filename + 1, ignores[i]))
        {
            free(ignores[i]);
            break;
        }
    }

    /* If we stopped some way across the array, move the rest up a bit */
    if (i < ignore_size)
    {
        for (; i < ignore_size; ++i)
        {
            ignores[i] = ignores[i + 1];
        }
        /* If we got this far, we must of removed an element */
        ignore_size -= 1;
    }

    /* No longer in the array */
    return 0;
}

/* Function to split a whitespace delimited list of differences and call
 * should_ignore on all of them */
int apply_changes(char* optgiven)
{
    char* thischange = NULL;

    if (optgiven == NULL)
    {
        fprintf(stderr, "Called apply_changes with NULL pointer\n");
        return 1;
    }

    /* Call should_ignore for all elements in the space-delimited list */
    thischange = strtok(optgiven, " ");
    while(thischange != NULL) {
        should_ignore(thischange);
        thischange = strtok(NULL, " ");
    }

    return 0;
}

/* Function to escape and strange filenames */
char* dot_escape(char* original)
{
    size_t j = 0, i = 0;
    static char thisname[200] = {0};
    while(original[i] != '\0' && j < 199) {
        /* If have to escape the character, do so */
        if (strchr("}{\\\"", original[i]))
        {
            thisname[j++] = '\\';
        }
        thisname[j++] = original[i++];
    }

    thisname[j] = '\0';

    return thisname;
}

/* Function to create label given the names */
char* find_label(char* dirname, char** files_contained, int* error_indicator)
{
    /* Need to add a '{', write the directory basename, add a '|' to the end
     * iterate over the names in files_contained adding the name and '\l' to it */
    static char thelabel[6001] = {0};
    char* tempname = NULL;
    size_t i = 0, len = 0;
    if (files_contained[0] == NULL)
    {
        return strncpy(thelabel, basename(dirname), 6001);
    }

    /* Add the directory name */
    snprintf(thelabel, 6000, "{%s|", basename(dirname));
    len += strlen(basename(dirname)) + 2;

    /* Add all the file names */
    while(files_contained[i] != NULL && len < 6000) {
        /* Add the filename in the array. */
        tempname = dot_escape(files_contained[i]);
        strncat(thelabel + len, tempname, 6000 - len);
        len += strlen(tempname);
        /* Make sure never call strncat with a negative size */
        if (len > 6000)
        {
            break;
        }
        /* Add the 'dot' new line indicator */
        strncat(thelabel + len, "\\l", 6000 - len);
        len += 2;
        i++;
    }

    /* print error if label has been truncated */
    if (len >= 6000)
    {
        /* Tell the caller that the label wasn't completed */
        *error_indicator = 1;
        /* reset len so the label gets closed */
        len = 6000;
    }

    /* Add the last '}' to the label and the null character */
    thelabel[len++] = '}';
    thelabel[len] = '\0';

    return thelabel;
}

/* dummy function at the moment.
 * not actually sure what this will do in the end */
int handle_symlink(struct dirent* thisent, Agnode_t* n)
{
    if (!n)
    {
        fprintf(stderr, "Can't handle symlink %s with no node\n", thisent->d_name);
    }
    return 0;
}

/* Takes a filename and adds the directory to the graph given.
 * If there is a non-null node given crates the new node linked to the previous
 * one.
 * Returns 1 if error reading directory.
 * Returns 2 if a filename was too large.
 * Returns 3 for other errors. */
int handle_directory(char* filename, Agraph_t* g, Agnode_t* n)
{
    Agedge_t* ed = NULL;
    Agnode_t* thisnode = NULL;
    char filenamebuf[999] = {0};
    char idnum[100] = {0};
    char* subdir_names[999] = {0};
    char* regfile_names[999] = {0};
    int doneflag = 1;
    int origerrno = errno;
    int retcode = 0;
    size_t i = strlen(filename);
    size_t newnamesize = 0;
    size_t num_subdirs = 0;
    size_t num_regfiles = 0;
    struct dirent* entry;
    static int counter = 0;

    /* If graph is NULL, return with error */
    if (g == NULL)
    {
        fprintf(stderr, "Called handle_directory with no graph\n");
        return 3;
    }

    /* pathname standardisation */
    /* Make sure the filename isn't too large */
    if (i >= 998)
    {
        fprintf(stderr, "Filename: %s is too large to handle\n", filename);
        return 2;
    }
    /* Copy and remove trailing '/' from filename if it's there */
    strcpy(filenamebuf, filename);
    if (filenamebuf[i - 1] != '/')
    {
        filenamebuf[i++] = '/';
    }

    /* Open the directory */
    DIR* thisdir = opendir(filename);
    if (!thisdir)
    {
        fprintf(stderr, "Error opening %s: %s\n", filename, strerror(errno));
        return 1;
    }

    /* Create a new node */
    snprintf(idnum, 100, "%d", counter++);
    thisnode = agnode(g, idnum, 1);
    /* If have been given a parent node, draw an anonymous edge to it */
    if (n != NULL)
    {
        ed = agedge(g, thisnode, n, NULL, 1);
    }

    /* Iterate over the elements in the directory */
    while( (entry = readdir(thisdir)) != NULL) {
        if (should_ignore(entry->d_name))
        {
            continue;
        }

        switch (entry->d_type) {

            /* If the file is a directory */
            case DT_DIR:

                newnamesize = i + strlen(entry->d_name);

                if (newnamesize >= 998)
                {
                    fprintf(stderr,
                            "entry: %s of directory: %s too large filename\n",
                            entry->d_name, filename);
                    doneflag = 0;
                    continue;
                }
                if (num_subdirs >= 999)
                {
                    fprintf(stderr,
                            "Directory %s has too many subdirectories\n",
                            filename);
                    doneflag = 0;
                    continue;
                }
                /* Add directory to stored directories */
                subdir_names[num_subdirs] = calloc(newnamesize + 1,
                                                        sizeof(char));
                snprintf(subdir_names[num_subdirs++], newnamesize + 1,
                        "%s%s", filenamebuf, entry->d_name);

                break;

            /* If the file is regular file */
            case DT_REG:

                /* If there are too many regular files, and don't add the name */
                if (num_regfiles >= 998)
                {
                    doneflag = 0;
                    continue;
                }

                /* Make sure not a rediculous amount of memory asked for */
                newnamesize = strlen(entry->d_name);
                if (newnamesize >= 998)
                {
                    fprintf(stderr,
                            "entry: %s of directory: %s too large filename\n",
                            entry->d_name, filename);
                    doneflag = 0;
                    continue;
                }
                /* Add regular file to list of file names (to create label for
                 * this node with)  */
                regfile_names[num_regfiles] = calloc(newnamesize + 1,
                                                        sizeof(char));
                strncpy(regfile_names[num_regfiles++],
                        entry->d_name, newnamesize + 1);
                break;

            /* If the file is a symlink - dummy function at the moment */
            case DT_LNK:
                handle_symlink(entry, thisnode);
                break;
        }

    }

    /* Close this directory */
    closedir(thisdir);

    /* Define the nodes label - find_label returns pointer to static buffer */
    agset(thisnode, "label", find_label(filename, regfile_names, &retcode));
    if (retcode == 1)
    {
        doneflag = 0;
    }
    for (i = 0; i < num_regfiles; ++i)
    {
        free(regfile_names[i]);
        regfile_names[i] = NULL;
    }

    /* Iterate over saved directory names */
    for (i = 0; i < num_subdirs; ++i)
    {
        retcode = handle_directory(subdir_names[i], g, thisnode);
        if (retcode == 2 || retcode == 3)
        {
            doneflag = 0;
        }
        free(subdir_names[i]);
    }

    /* Check for errors */
    if (errno != origerrno)
    {
        fprintf(stderr, "Error reading directory: %s  - %s\n",
                filename, strerror(errno));
        return 1;
    }
    if (!doneflag)
    {
        return 2;
    }

    return 0;
}

/* Define new graph */
Agraph_t* new_graph(char* filename)
{
    int retcode = 0;

    /* Create a new graph - not sure how to check these functions */
    Agraph_t* newgraph = agopen(filename, Agstrictdirected, NULL);
    agattr(newgraph, AGNODE, "shape", "record");
    agattr(newgraph, AGRAPH, "rankdir", "BT");
    agattr(newgraph, AGNODE, "label", filename);

    /* Start iterating over the directory */
    retcode = handle_directory(filename, newgraph, NULL);

    /* Check the return code and return the graph */
    if (retcode == 1)
    {
        fprintf(stderr, "Error handling %s\n", filename);
    } else if (retcode == 2)
    {
        fprintf(stderr, "Some subdirectory was too large in %s\n", filename);
    }

    return newgraph;
}


/* How should I allow adding and removing directories from the ignore list?
 *      Should I have a single argument that allows multiple differences from
 *      the default?
 *      Should I allow full pathnames?
 *      What about two different options, one to remove a directory and one to
 *      add to a directory?  */
/* "program name"  "top directory"  "dot arguments" */
int main(int argc, char *argv[])
{
    int myret = 0;
    int i;

    /* Check we've been given a top directory */
    if (argc < 2)
    {
        fprintf(stderr, "Usage: %s top directory [dot options] \n\
                [--ignore_list (list directory names to ignore)\n", argv[0]);
        return 0;
    }

    /* Add the default directories to ignore */
    char* standard_ignores[] = {"+.mozilla", "+.git", "+.hg", "+vim_repo",
                              "+.", "+..", "+.svn"};
    for (i = 0; i < 7; ++i)
    {
        should_ignore(standard_ignores[i]);
    }

    /* Iterate i until either reach end of arguments or find ignore option */
    for (i = 2; i < argc; ++i)
    {
        if (!strncmp(argv[i], "--ignore_change", 15))
        {
            break;
        }
    }

    /* If didn't get to the end of the argument list, found ignore option */
    if (i < argc)
    {
        if (strlen(argv[i]) > 15)
        {
            /* The argument and the option identifier are one argument */
            apply_changes(argv[i] + 15);
            /* Remove this element from argc and shift all others along */
            for (; i < argc - 1; ++i)
            {
                argv[i] = argv[i + 1];
            }
            argc -= 1;
        } else {
            apply_changes(argv[i + 1]);
            /* Remove the two elements from argv and shift all others along */
            for (; i < argc - 2; ++i)
            {
                argv[i] = argv[i + 2];
            }
            argc -= 2;
        }

    }

    /* Create the graph from the directory given */
    Agraph_t* mygraph = new_graph(argv[1]);

    /* Draw the graph as a png and write to file given */
    GVC_t* gvc = gvContext();
    if (gvc == NULL)
    {
        fprintf(stderr, "Error creating gvContext\n");
        return 1;
    }

    /* Override the filename with 'dot' so the dot arguments are used for
     * parsing in gvParseArgs */
    argv[1] = "dot";

    /* Use the library function to parse the dot arguments */
    myret = gvParseArgs(gvc, argc - 1, argv + 1);
    gvLayoutJobs(gvc, mygraph);
    gvRenderJobs(gvc, mygraph);

    /* Clear up */
    gvFreeLayout(gvc, mygraph);
    agclose(mygraph);
    gvFreeContext(gvc);

    return 0;
}

