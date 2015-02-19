#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <bsd/string.h>
#include <X11/Xlib.h>
#include <X11/Xatom.h>

/* Mess with the clipboard -- playing to understand how everything works. */

static char encoding_table[] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H',
                                'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P',
                                'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X',
                                'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
                                'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
                                'o', 'p', 'q', 'r', 's', 't', 'u', 'v',
                                'w', 'x', 'y', 'z', '0', '1', '2', '3',
                                '4', '5', '6', '7', '8', '9', '+', '/'};
static unsigned int mod_table[] = {0, 2, 1};

static char* special_messages[] = {"No selection yet",
                                   "Non-text data",
                                   "Lots and Lots of words"};

char *base64_encode(const unsigned char *data,
                    size_t input_length,
                    size_t *output_length) {
    size_t i, j;

    *output_length = 4 * ((input_length + 2) / 3);

    char *encoded_data = malloc(*output_length);
    if (encoded_data == NULL) return NULL;

    for (i = 0, j = 0; i < input_length;) {

        uint32_t octet_a = i < input_length ? (unsigned char)data[i++] : 0;
        uint32_t octet_b = i < input_length ? (unsigned char)data[i++] : 0;
        uint32_t octet_c = i < input_length ? (unsigned char)data[i++] : 0;

        uint32_t triple = (octet_a << 0x10) + (octet_b << 0x08) + octet_c;

        encoded_data[j++] = encoding_table[(triple >> 3 * 6) & 0x3F];
        encoded_data[j++] = encoding_table[(triple >> 2 * 6) & 0x3F];
        encoded_data[j++] = encoding_table[(triple >> 1 * 6) & 0x3F];
        encoded_data[j++] = encoding_table[(triple >> 0 * 6) & 0x3F];
    }

    for (i = 0; i < mod_table[input_length % 3]; i++)
        encoded_data[*output_length - 1 - i] = '=';

    return encoded_data;
}

int is_special_message(const char* the_message)
{
    size_t i = 0;
    for (i = 0; i < sizeof(special_messages) / sizeof(special_messages[0]); i++)
    {
        if (!strcmp(special_messages[i], the_message)) {
            return 1;
        }
    }
    return 0;
}

int b64enc_string(char* original, size_t buffer_len)
{
    size_t output_len = 0;
    if (is_special_message(original)) {
        return 0;
    }
    
    char* modified_str = base64_encode((unsigned char* )original,
                                       strlen(original),
                                       &output_len);
    if (output_len > buffer_len) {
        return 1;
    }
    strlcpy(original, modified_str, buffer_len);
    free(modified_str);
    return 0;
}

/*
 * This program is here to modify all clipboard selections made based on some function.
 *
 * The outline of the program is:
 *      On start:
 *          Find selection.
 *          Acquire selection.
 *          If selection is type STRING
 *              Transform according to function.
 *              Put transformed data in selection.
 *          Otherwise
 *              Put 'My place holder' in selection.
 *      
 *      Loop doing:
 *          If asked for selection, return it.
 *          If told to release selection:
 *              Release selection.
 *              Read selection other program has made.
 *              Acquire selection
 *              If selection is type STRING
 *                  Transform according to function
 *                  Put transformed data in selection.
 *              Otherwise
 *                  Put 'My place holder' in selection.
 */

int read_my_property(Display* dpy, Window w, Atom property,
                     char* buffer, size_t buf_len)
{
    Atom actual_type;
    int actual_format, retval;
    int read_bytes;
    size_t len_selection;
    unsigned long nitems;
    unsigned long bytes_after;
    unsigned char *ret=0;

    /* XGetWindowProperty reads the data of the property into "ret"
     * I don't know if this is required to be null terminated
     *     the function can't require it as there could be non-string data
     *     but it might be that a text selection will have the null character
     *     anyway
     *
     * Will limit the read of the property to 1 less characters than the buffer.
     * If bytes_after is non-null, the buffer is too small for the selection.
     * Otherwise, the buffer is large enough.
     */
    
    /* Length in 32 bit multiples of the data to be retreived */
    read_bytes = (int) buf_len / 32;
    /* NOTE: '31' is the "STRING" type */
    XGetWindowProperty(dpy, w, property, 0, read_bytes, False, 31, &actual_type,
                       &actual_format, &nitems, &bytes_after, &ret);

    if (!bytes_after) {
        len_selection = strlcpy(buffer, (char*) ret, buf_len);
        retval = len_selection > buf_len;
    }
    else {
        retval = 1;
    }
    XFree(ret);
    
    return retval;
}

size_t get_selection(Display* dpy, Atom selection, Window my_win,
                     char* my_buf, size_t buf_len)
{
    /* Ask for STRING type only.
       Ask for selection on my window property (whatever, doesn't matter)
       Once get the selection notify event, read the property.
       If the property is larger than 2048, could use realloc
       For now will simply put "Lots and lots of words" in my_buf
    */
    Atom store_here = selection;
    Atom target;
    int retval = 0;
    size_t len_selection;
    XEvent e;
    char* no_selection_message = special_messages[0];
    char* non_text_message = special_messages[1];
    char* too_long_message = special_messages[2];

    XConvertSelection(dpy, selection, XA_STRING,
                      store_here, my_win, CurrentTime);
    XFlush(dpy);

    for (;;)
    {
        XNextEvent(dpy, &e);

        if (e.type != SelectionNotify) {
            continue;
        }

        target = e.xselection.target;

        /* Couldn't get property for some reason */
        if (e.xselection.property == None)
        {
            /* If no-one owns the selection, or selection could not be
               converted, put corresponding message in buffer */
            if (target != XA_STRING) {
                len_selection = strlcpy(my_buf, no_selection_message, buf_len);
            }
            else {
                len_selection = strlcpy(my_buf, non_text_message, buf_len);
            }
            /* Have set the buffer, return with error status */
            retval = len_selection > buf_len;
            break;
        }


        if (target == XA_STRING)
        {
            if (read_my_property(dpy, my_win, store_here, my_buf, buf_len)) {
                len_selection = strlcpy(my_buf, too_long_message, buf_len);
                retval = len_selection > buf_len;
            }
            break;
        }
        else
        {   // Something very strange happening - exit with error.
            retval = -2;
            break;
        }

    }

    if (!strcmp(my_buf, "stop now")) {
        retval = 1;
    }

    return retval;
}


int distribute_modified_selection(Display* dpy, Atom selection_type,
                                  char* my_message)
{
    XEvent e, response;
    XSelectionRequestEvent *req;
    Atom XA_UTF8_STRING    = XInternAtom(dpy, "UTF8_STRING", 0);
    Atom XA_TARGETS        = XInternAtom(dpy, "TARGETS", 0);
    Atom supported_types[] = {XA_STRING, XA_UTF8_STRING};
    int return_value       = 0;

    /* Set the parts of the SelectionNotify that we already know */
    response.type                 = SelectionNotify;
    response.xselection.display   = dpy;
    response.xselection.selection = selection_type;

    for (;;)
    {
        XNextEvent(dpy, &e);

        if (e.type != SelectionRequest && e.type != SelectionClear) {
            continue;
        }

        /* If given SelectionClear let the other client have the selection and
           leave the loop */
        if (e.type == SelectionClear) {
            break;
        }

        /*
         * We have been given a SelectionRequest,
         * check it's for the selection I'm looking for.
         * If not, exit assuming I have the wrong type of selection.
         */
        if (e.xselectionrequest.selection != selection_type) {
            return_value = 1;
            break;
        }

        req = &(e.xselectionrequest);

        if (req->target == XA_TARGETS) {
            XChangeProperty(dpy,
                            req->requestor,
                            req->property,
                            XA_TARGETS,
                            8,
                            PropModeReplace,
                            (unsigned char*) (&supported_types),
                            sizeof(supported_types));

            response.xselection.property = req->property;
        }
        else if (req->target == XA_STRING || req->target == XA_UTF8_STRING) {
            XChangeProperty(dpy,
                            req->requestor,
                            req->property,
                            req->target,
                            8,
                            PropModeReplace,
                            (unsigned char*) my_message,
                            strlen(my_message) + 1);
            
            response.xselection.property = req->property;
        } 
        else {
            response.xselection.property = None;
        }

        response.xselection.requestor = req->requestor;
        response.xselection.target    = req->target;
        response.xselection.time      = req->time;

        XSendEvent(dpy, req->requestor, 0, 0, &response);
        XFlush(dpy);
    }

    return return_value;
}


int main()
{

    Display* dpy;
    int      should_stop;
    int      screen;
    Window   mywin, root;
    Atom     CLIP;
    char*    clipboard_contents;
    size_t   MAX_SELECTION_LENGTH = 2048;
    /* will be chosen from a random choice of an array of functions */
    int (*modify_string)(char*, size_t);
    modify_string = b64enc_string;

    dpy = XOpenDisplay(NULL);
    if (dpy == NULL)
    {
        puts("Could not open connection to X server");
        return 1;
    }

    clipboard_contents = calloc(MAX_SELECTION_LENGTH, sizeof(char));
    
    screen = DefaultScreen(dpy);
    root   = RootWindow(dpy, screen);
    mywin  = XCreateSimpleWindow(dpy, root, 0, 0, 100, 100, 0,
                                 BlackPixel(dpy, screen),
                                 BlackPixel(dpy, screen));
    CLIP   = XInternAtom(dpy, "CLIPBOARD", 0);

    /* Get the current selection */
    should_stop = 0;
    while(1) {
        /* This gets the selection into clipboard_contents, if it's too big it
         * puts "Lots and lots words", if it's not text it puts "Non-text data"
         */
        if (get_selection(dpy, CLIP, mywin,
                          clipboard_contents, MAX_SELECTION_LENGTH)) {
            break;
        }

        
        /* modify_string attempts to change the string in clipboard_contents
           within the limitation of staying in MAX_SELECTION_LENGTH bytes */
        if (modify_string(clipboard_contents, MAX_SELECTION_LENGTH)) {
            break;
        }

        XSetSelectionOwner(dpy, CLIP, mywin, CurrentTime);
        /* This gives out the data to anyone that asks for it. */
        if (distribute_modified_selection(dpy, CLIP, clipboard_contents)) {
            break;
        }

    }

    free(clipboard_contents);

    return 0;
}
