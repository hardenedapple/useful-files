#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <X11/Xlib.h>

/* Configuration of the positions (information about preferences */
#define TOP_EDGE 0.008
#define BOTTOM_EDGE 0.008
#define LEFT_EDGE 0.006
#define RIGHT_EDGE 0.006
#define TASKBARTOP 0
#define TASKBARLEFT 0
#define TASKBARRIGHT 0
#define TASKBARBOTTOM 20

/* set makeprg=clang\ -Wall\ -W\ -Werror\ -lX11\ -lm\ -o\ %:r\ % | make */


/* TODO: Haven't yet accounted for multiple monitors with Xrandr
 *       Think XRRScreenConfiguration might be the way to look for monitor size */

/*
 *  Notes:
 *      Assumes the window extends downwards and to the right.
 *
 *      Compared to window_move.py, this program doesn't run as a daemon
 *
 *      This is because opening a connection to the X server isn't nearly as
 *      costly in C (don't know why) so the responsiveness isn't a problem.
 *
 *      This means this program opens the display and finds the root window
 *      that you are on whenever you use it - meaning Zaphod mode works.
 *
 *      Am assuming want to move the highest parent of the window you are
 *      focussed on that is still a child of the root window. This helps
 *      account for reparenting window managers.
 */

/* Structure for names and function pointers the position functions */
struct func_and_name {
    char* function_name;
    XWindowChanges (*function)(const XWindowChanges, const XWindowChanges);
};

/*****************************************************************************
 *      Position defining functions and function to choose which to use      *
 *****************************************************************************/

/* Put the window in the top left of the screen */
XWindowChanges top_left(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    return_val.x = (int) floor(root_geom.width * LEFT_EDGE) + TASKBARLEFT;
    return_val.y = (int) floor(root_geom.height * TOP_EDGE) + TASKBARTOP;
    return return_val;
}

/* Put the window at the top right of the screen */
XWindowChanges top_right(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int right_edge = (int) floor(root_geom.width * (1 - RIGHT_EDGE)) - TASKBARRIGHT;
    return_val.x = right_edge - current_pos.width;
    return_val.y = (int) floor(root_geom.height * TOP_EDGE) - TASKBARTOP;
    return return_val;
}

/* Put the window at the bottom right of the screen */
XWindowChanges bottom_right(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int right_edge = (int) floor(root_geom.width * (1 - RIGHT_EDGE)) - TASKBARRIGHT;
    int bottom_edge = (int) floor(root_geom.height * (1 - BOTTOM_EDGE)) - TASKBARBOTTOM;
    return_val.x = right_edge - current_pos.width;
    return_val.y = bottom_edge - current_pos.height;

    return return_val;
}

/* Put the window at the bottom left of the screen */
XWindowChanges bottom_left(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int bottom_edge = (int) floor(root_geom.height * (1 - BOTTOM_EDGE)) - TASKBARBOTTOM;
    return_val.x = (int) floor(root_geom.width * LEFT_EDGE) + TASKBARLEFT;
    return_val.y = bottom_edge - current_pos.height;

    return return_val;
}

/* Put the window in the middle of the top edge */
XWindowChanges top_middle(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int middle_horizontal = (root_geom.width - TASKBARRIGHT - TASKBARLEFT) / 2;
    return_val.x = middle_horizontal - (current_pos.width / 2) + TASKBARLEFT;
    return_val.y = (int) floor(root_geom.height * TOP_EDGE) - TASKBARTOP;

    return return_val;
}

/* Put the window in the middle of the bottom edge */
XWindowChanges bottom_middle(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int middle_horizontal = (root_geom.width - TASKBARRIGHT - TASKBARLEFT) / 2;
    int bottom_edge = (int) floor(root_geom.height * (1 - BOTTOM_EDGE)) - TASKBARBOTTOM;
    return_val.x = middle_horizontal - (current_pos.width / 2) + TASKBARLEFT;
    return_val.y = bottom_edge - current_pos.height;

    return return_val;
}

/* Put the window in the middle of the left edge */
XWindowChanges middle_left(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int middle_vertical = (root_geom.height - TASKBARBOTTOM - TASKBARTOP) / 2;
    return_val.x = (int) floor(root_geom.width * LEFT_EDGE) + TASKBARLEFT;
    return_val.y = middle_vertical - (current_pos.height / 2) + TASKBARTOP;

    return return_val;
}

/* Put the window in the middle of the right edge */
XWindowChanges middle_right(const XWindowChanges current_pos, const XWindowChanges root_geom)
{
    XWindowChanges return_val = current_pos;
    int middle_vertical = (root_geom.height - TASKBARBOTTOM - TASKBARTOP) / 2;
    int right_edge = (int) floor(root_geom.width * (1 - RIGHT_EDGE)) - TASKBARRIGHT;
    return_val.x = right_edge - current_pos.width;
    return_val.y = middle_vertical - (current_pos.height / 2) + TASKBARTOP;

    return return_val;
}

static struct func_and_name positions[] = {{"tl", top_left}, {"tr", top_right},
                                     {"bl", bottom_left}, {"br", bottom_right},
                                     {"mr", middle_right}, {"ml", middle_left},
                                     {"tm", top_middle}, {"bm", bottom_middle},
                                     {NULL, NULL}};
/* Return the function corresponding to a choice */
XWindowChanges (*find_snap_function(const char* choice))(XWindowChanges, XWindowChanges)
{
    int i = 0;
    while(positions[i].function_name != NULL) {
        if (strcmp(choice, positions[i].function_name) == 0)
        {
            return positions[i].function;
        }
        i++;
    }
    return NULL;
}

/******************************
 *  Functions defining sizes  *
 ******************************/

/* Small size */
XWindowChanges small(const XWindowChanges cur_geom, const XWindowChanges root_geom)
{
    XWindowChanges return_geom = cur_geom;
    int right_edge = (int) floor(root_geom.width * (1 - RIGHT_EDGE)) - TASKBARRIGHT;
    int bottom_edge = (int) floor(root_geom.height * (1 - BOTTOM_EDGE)) - TASKBARBOTTOM;
    return_geom.width = (int) (root_geom.width * 0.3);
    return_geom.height = (int) (root_geom.height * 0.3);
    if (return_geom.width + return_geom.x > right_edge)
    {
        return_geom.x -= return_geom.x + return_geom.width - right_edge;
    }
    if (return_geom.height + return_geom.y > bottom_edge)
    {
        return_geom.y -= return_geom.y + return_geom.height - bottom_edge;
    }

    return return_geom;
}

/* Tall size */
XWindowChanges tall(const XWindowChanges cur_geom, const XWindowChanges root_geom)
{
    XWindowChanges return_geom = cur_geom;
    int right_edge = (int) floor(root_geom.width * (1 - RIGHT_EDGE)) - TASKBARRIGHT;
    int bottom_edge = (int) floor(root_geom.height * (1 - BOTTOM_EDGE)) - TASKBARBOTTOM;
    return_geom.width = (int) (root_geom.width * 0.35);
    return_geom.height = (int) (root_geom.height * 0.95);
    if (return_geom.width + return_geom.x > right_edge)
    {
        return_geom.x -= return_geom.x + return_geom.width - right_edge;
    }
    if (return_geom.height + return_geom.y > bottom_edge)
    {
        return_geom.y -= return_geom.y + return_geom.height - bottom_edge;
    }

    return return_geom;
}

/* Normal size */
XWindowChanges normal(const XWindowChanges cur_geom, const XWindowChanges root_geom)
{
    XWindowChanges return_geom = cur_geom;
    int right_edge = (int) floor(root_geom.width * (1 - RIGHT_EDGE)) - TASKBARRIGHT;
    int bottom_edge = (int) floor(root_geom.height * (1 - BOTTOM_EDGE)) - TASKBARBOTTOM;
    return_geom.width = (int) (root_geom.width * 0.35);
    return_geom.height = (int) (root_geom.height * 0.35);
    if (return_geom.width + return_geom.x > right_edge)
    {
        return_geom.x -= return_geom.x + return_geom.width - right_edge;
    }
    if (return_geom.height + return_geom.y > bottom_edge)
    {
        return_geom.y -= return_geom.y + return_geom.height - bottom_edge;
    }

    return return_geom;
}

static struct func_and_name sizes[] = {{"normal", normal},
                                       {"small", small}, {"tall", tall}};

/* Return the function corresponding to a choice of size */
XWindowChanges (*find_resize_function(const char* choice))(XWindowChanges, XWindowChanges)
{
    int i = 0;
    while(sizes[i].function_name != NULL) {
        if (strcmp(choice, sizes[i].function_name) == 0)
        {
            return sizes[i].function;
        }
        i++;
    }
    return NULL;
}



/*****************************************************************************
 *            Implementation functions - act on position                     *
 *****************************************************************************/

/* Function that finds the geometry of the window that is a parent of given
 * window and a first generation child of the root window - hence the one I
 * want to move */
XWindowChanges find_geom(Display* dpy, Window the_win, XWindowChanges root_geometry)
{
    XWindowChanges my_geometry = {0, 0, 0, 0, 0, 0, 0};
    XWindowChanges parent_geometry = {0, 0, 0, 0, 0, 0, 0};
    Window root_win = 0, parent_win = 0, *children_windows = NULL;
    unsigned int win_depth = 0;
    unsigned int num_children = 0;
    int still_exists = 0;

    /* set the parent window to equal the given window - so the loop works nice */
    parent_win = the_win;

    /* Iterate up the window tree until reach root, the interesting window is
     * the previous one */
    while(root_geometry.width > parent_geometry.width
          || root_geometry.height > parent_geometry.height) {

        /* Take the parent window */
        the_win = parent_win;
        my_geometry = parent_geometry;

        /* Find the next parent window - don't care about a lot of the return
         * values here */
        still_exists = XQueryTree(dpy, the_win, &root_win, &parent_win,
                                  &children_windows, &num_children);

        /* Find the parents geometry */
        still_exists = XGetGeometry(dpy, parent_win, &root_win,
                                    &parent_geometry.x, &parent_geometry.y,
                                    (unsigned int*) &parent_geometry.width,
                                    (unsigned int*) &parent_geometry.height,
                                    (unsigned int*) &parent_geometry.border_width,
                                    &win_depth);
    }

    /* Have found the geometry we were looking for - it is in 'my_geometry' */
    return my_geometry;
}

/* Function to actually move the window */
int snap_to(Display* dpy, const char* position, const XWindowChanges root_geom)
{
    Window current = 0;
    int focus_state = 0;
    XWindowChanges (*move_func)(XWindowChanges, XWindowChanges);
    move_func = find_snap_function(position);
    if (move_func == NULL)
    {
        return -1;
    }

    XGetInputFocus(dpy, &current, &focus_state);
    XWindowChanges cur_geom = find_geom(dpy, current, root_geom);
    XWindowChanges new_geom = move_func(cur_geom, root_geom);
    XMoveWindow(dpy, current, new_geom.x, new_geom.y);
    XFlush(dpy);
    return 0;
}

/* Function to actually resize the window */
int resize_to(Display* dpy, const char* size, const XWindowChanges root_geom)
{
    Window current = 0;
    int focus_type = 0;
    XWindowChanges (*resize_func)(XWindowChanges, XWindowChanges);
    resize_func = find_resize_function(size);
    if (resize_func == NULL)
    {
        return -1;
    }

    XGetInputFocus(dpy, &current, &focus_type);
    XWindowChanges cur_geom = find_geom(dpy, current, root_geom);
    XWindowChanges new_geom = resize_func(cur_geom, root_geom);
    XMoveResizeWindow(dpy, current, new_geom.x, new_geom.y, 
                      (unsigned int) new_geom.width,
                      (unsigned int) new_geom.height);
    XFlush(dpy);
    return 0;
}

/* Main program: 
 *      Open the connection to the X server
 *      Read in the geometry of the root window
 *      Call the function specified by the argument list
 */
int main(int argc, char* argv[])
{
    Display* dpy = NULL;
    Window root_win;
    int still_exists = 0;
    unsigned int win_depth = 0;
    XWindowChanges root_geom = {0, 0, 0, 0, 0, 0, 0};

    /* Make sure the display opened correctly */
    dpy = XOpenDisplay(NULL);
    if (!dpy)
    {
        fprintf(stderr, "Error opening display\n");
        return 1;
    }

    root_win = DefaultRootWindow(dpy);

    /* Find the geometry of the root window to use later */
    still_exists = XGetGeometry(dpy, root_win, &root_win,
                                &root_geom.x, &root_geom.y,
                                (unsigned int*) &root_geom.width,
                                (unsigned int*) &root_geom.height,
                                (unsigned int*) &root_geom.border_width,
                                &win_depth);
    if (!still_exists)
    {
        fprintf(stderr, "Error getting root window geometry\n");
        return 1;
    }

    /* Argument parsing - either motion or resize command */
    if (argc == 3 && !strcmp(argv[1], "snap_to"))
    {
        snap_to(dpy, argv[2], root_geom);
    } else if (argc == 3 && !strcmp(argv[1], "resize_to")) {
        resize_to(dpy,argv[2], root_geom);
    } else {
        /* Not valid arguments - print usage and do nothing */
        printf("Usage: %s [[snap_to position] | [resize_to position]]\n", argv[0]);
    }

    return 0;
}

