#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <X11/Xlib.h>
#include <X11/extensions/Xrandr.h>
#include <X11/Xatom.h>

/* Configuration of the positions (information about preferences */
#define TOP_EDGE 0.008
#define BOTTOM_EDGE 0.008
#define LEFT_EDGE 0.006
#define RIGHT_EDGE 0.006

/* set makeprg=clang\ -Wall\ -W\ -Werror\ -lX11\ -lXrandr\ -lm\ -o\ %:r\ % */

/* TODO:
 *  Finding main geometry:
 *      Most wm's now are reparenting.
 *      I beleive I could just assume this, and take the first parent.
 *      I'm not 100% confident on this.
 *      At the moment, I go up the tree of window parents until I meet the
 *      window that is the child of the root.
 *      This might not work well in all wm's, possibly should use the
 *      _NET_VIRTUAL_ROOTS atom as specified in
 *      http://standards.freedesktop.org/wm-spec/wm-spec-1.3.html
 *
 *  Finding workarea:
 *      Some wm's (including those I use) don't set _NET_WM_WORKAREA.
 *      When this is true, I have to find the workarea out myself.
 *      At the moment I do this by iterating over all the windows in the server
 *      and asking each how much space they are reserving on the edges.
 *      This could be done much faster using the xcb library instead of Xlib.
 *
 *      Sometimes, when the workarea is set, it includes multiple monitors in
 *      the same workarea.
 *      This is not what I want.
 *      Will add a compiler option to allow the option to never use the
 *      _NET_WM_WORKAREA property.
 *
 *  Refactoring code:
 *      I want to make one function that moves windows to the position
 *      specified (tell it which corner to position and where to put that
 *      corner) and implement all snaps by calling that function.
 *
 *      Want to do the same to resizing functions.
 *
 *      This will make adding command line options to choose everything much
 *      easier.
 */

/*
 *  Notes:
 *      Assumes the window extends downwards and to the right.
 *
 *      Am assuming want to move the highest parent of the window you are
 *      focussed on that is still a child of the root window. This helps
 *      account for reparenting window managers.
 */

/* Structure for names and function pointers the position functions */
struct func_and_name {
    char *function_name;
     XWindowChanges(*function) (const XWindowChanges, const XWindowChanges);
};

struct taskbar_sizes {
    int top, left, right, bottom;
};

/*****************************************************************************
 *      Position defining functions and function to choose which to use      *
 *****************************************************************************/

/* Put the window in the top left of the screen */
XWindowChanges top_left(const XWindowChanges current_pos,
                        const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    return_val.x = workarea.x + (int)floor(workarea.width * LEFT_EDGE);
    return_val.y = workarea.y + (int)floor(workarea.height * TOP_EDGE);
    return return_val;
}

/* Put the window at the top right of the screen */
XWindowChanges top_right(const XWindowChanges current_pos,
                         const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int right_edge = workarea.x + (int)floor(workarea.width * (1 - RIGHT_EDGE));
    return_val.x = right_edge - current_pos.width;
    return_val.y = workarea.y + (int)floor(workarea.height * TOP_EDGE);
    return return_val;
}

/* Put the window at the bottom right of the screen */
XWindowChanges bottom_right(const XWindowChanges current_pos,
                            const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int right_edge = workarea.x + (int)floor(workarea.width * (1 - RIGHT_EDGE));
    int bottom_edge =
        workarea.y + (int)floor(workarea.height * (1 - BOTTOM_EDGE));
    return_val.x = right_edge - current_pos.width;
    return_val.y = bottom_edge - current_pos.height;

    return return_val;
}

/* Put the window at the bottom left of the screen */
XWindowChanges bottom_left(const XWindowChanges current_pos,
                           const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int bottom_edge = workarea.y +
        (int)floor(workarea.height * (1 - BOTTOM_EDGE));
    return_val.x = workarea.x + (int)floor(workarea.width * LEFT_EDGE);
    return_val.y = bottom_edge - current_pos.height;

    return return_val;
}

/* Put the window in the middle of the top edge */
XWindowChanges top_middle(const XWindowChanges current_pos,
                          const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int middle_horizontal = workarea.x + (workarea.width) / 2;
    return_val.x = middle_horizontal - (current_pos.width / 2);
    return_val.y = workarea.y + (int)floor(workarea.height * TOP_EDGE);

    return return_val;
}

/* Put the window in the middle of the bottom edge */
XWindowChanges bottom_middle(const XWindowChanges current_pos,
                             const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int middle_horizontal = workarea.x + (workarea.width) / 2;
    int bottom_edge =
        workarea.y + (int)floor(workarea.height * (1 - BOTTOM_EDGE));
    return_val.x = middle_horizontal - (current_pos.width / 2);
    return_val.y = bottom_edge - current_pos.height;

    return return_val;
}

/* Put the window in the middle of the left edge */
XWindowChanges middle_left(const XWindowChanges current_pos,
                           const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int middle_vertical = workarea.y + (workarea.height) / 2;
    return_val.x = workarea.x + (int)floor(workarea.width * LEFT_EDGE);
    return_val.y = middle_vertical - (current_pos.height / 2);

    return return_val;
}

/* Put the window in the middle of the right edge */
XWindowChanges middle_right(const XWindowChanges current_pos,
                            const XWindowChanges workarea)
{
    XWindowChanges return_val = current_pos;
    int middle_vertical = workarea.y + (workarea.height) / 2;
    int right_edge = workarea.x + (int)floor(workarea.width * (1 - RIGHT_EDGE));
    return_val.x = right_edge - current_pos.width;
    return_val.y = middle_vertical - (current_pos.height / 2);

    return return_val;
}

static struct func_and_name positions[] = { {"tl", top_left}, {"tr", top_right},
{"bl", bottom_left}, {"br", bottom_right},
{"mr", middle_right}, {"ml", middle_left},
{"tm", top_middle}, {"bm", bottom_middle},
{NULL, NULL}
};

/* Return the function corresponding to a choice */
XWindowChanges(*find_snap_function(const char *choice)) (XWindowChanges,
                                                         XWindowChanges) {
    int i = 0;
    while (positions[i].function_name != NULL) {
        if (strcmp(choice, positions[i].function_name) == 0) {
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
XWindowChanges small(const XWindowChanges cur_geom,
                     const XWindowChanges workarea)
{
    XWindowChanges return_geom = cur_geom;
    int right_edge = workarea.x + (int)floor(workarea.width * (1 - RIGHT_EDGE));
    int bottom_edge =
        workarea.y + (int)floor(workarea.height * (1 - BOTTOM_EDGE));
    return_geom.width = (int)(workarea.width * 0.3);
    return_geom.height = (int)(workarea.height * 0.3);
    if (return_geom.width + return_geom.x > right_edge) {
        return_geom.x -= return_geom.x + return_geom.width - right_edge;
    }
    if (return_geom.height + return_geom.y > bottom_edge) {
        return_geom.y -= return_geom.y + return_geom.height - bottom_edge;
    }

    return return_geom;
}

/* Tall size */
XWindowChanges tall(const XWindowChanges cur_geom,
                    const XWindowChanges workarea)
{
    XWindowChanges return_geom = cur_geom;
    int right_edge = workarea.x + (int)floor(workarea.width * (1 - RIGHT_EDGE));
    int bottom_edge =
        workarea.y + (int)floor(workarea.height * (1 - BOTTOM_EDGE));
    return_geom.width = (int)(workarea.width * 0.35);
    return_geom.height = (int)(workarea.height * 0.95);
    if (return_geom.width + return_geom.x > right_edge) {
        return_geom.x -= return_geom.x + return_geom.width - right_edge;
    }
    if (return_geom.height + return_geom.y > bottom_edge) {
        return_geom.y -= return_geom.y + return_geom.height - bottom_edge;
    }

    return return_geom;
}

/* Normal size */
XWindowChanges normal(const XWindowChanges cur_geom,
                      const XWindowChanges workarea)
{
    XWindowChanges return_geom = cur_geom;
    int right_edge = workarea.x + (int)floor(workarea.width * (1 - RIGHT_EDGE));
    int bottom_edge =
        workarea.y + (int)floor(workarea.height * (1 - BOTTOM_EDGE));
    return_geom.width = (int)(workarea.width * 0.35);
    return_geom.height = (int)(workarea.height * 0.35);
    if (return_geom.width + return_geom.x > right_edge) {
        return_geom.x -= return_geom.x + return_geom.width - right_edge;
    }
    if (return_geom.height + return_geom.y > bottom_edge) {
        return_geom.y -= return_geom.y + return_geom.height - bottom_edge;
    }

    return return_geom;
}

static struct func_and_name sizes[] = { {"normal", normal},
{"small", small}, {"tall", tall}
};

/* Return the function corresponding to a choice of size */
XWindowChanges(*find_resize_function(const char *choice)) (XWindowChanges,
                                                           XWindowChanges) {
    int i = 0;
    while (sizes[i].function_name != NULL) {
        if (strcmp(choice, sizes[i].function_name) == 0) {
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
XWindowChanges find_geom(Display * dpy, Window the_win)
{
    XWindowChanges my_geometry = { 0, 0, 0, 0, 0, 0, 0 };
    Window root_win = 0, parent_win = 0, *children_windows = NULL;
    unsigned int win_depth = 0;
    unsigned int num_children = 0;
    int still_exists = 0;

    /* set the parent window to equal the given window - so the loop works nice */
    parent_win = the_win;

    /* Iterate up the window tree until reach root, the interesting window is
     * the previous one */
    while (parent_win != root_win) {

        /* Take the parent window */
        the_win = parent_win;

        /* Find the next parent window - don't care about a lot of the return
         * values here */
        still_exists = XQueryTree(dpy, the_win, &root_win, &parent_win,
                                  &children_windows, &num_children);
    }

    /* Find my geometry */
    still_exists = XGetGeometry(dpy, the_win, &root_win,
                                &my_geometry.x, &my_geometry.y,
                                (unsigned int *)&my_geometry.width,
                                (unsigned int *)&my_geometry.height,
                                (unsigned int *)&my_geometry.border_width,
                                &win_depth);

    /* Have found the geometry we were looking for - it is in 'my_geometry' */
    return my_geometry;
}

void ApplyMove(Display * dpy, Window current, XWindowChanges new_geom)
{
    XMoveWindow(dpy, current, new_geom.x, new_geom.y);
    XFlush(dpy);
}

void ApplyResize(Display * dpy, Window current, XWindowChanges new_geom)
{
    XMoveResizeWindow(dpy, current, new_geom.x, new_geom.y,
                      (unsigned)new_geom.width, (unsigned)new_geom.height);
    XFlush(dpy);
}

/*****************************************************************************
 *                         Find the taskbar heights.                         *
 *****************************************************************************/

int search_windows_for_taskbars(Display * dpy, Window window,
                                Atom wm_strut_partial,
                                struct taskbar_sizes *edges)
{
    int retval = 0;
    Atom *return_values;
    Atom actual_type;
    int actual_format, num_items_to_read = 30;
    Window parent_return, root_return;
    Window *children;
    unsigned n_children, i;
    unsigned long nitems_read = 0, bytes_after;
    unsigned char *ret_data = 0;

    XQueryTree(dpy, window, &root_return,
               &parent_return, &children, &n_children);

    for (i = 0; i < n_children; ++i) {
        XGetWindowProperty(dpy, children[i], wm_strut_partial, 0,
                           num_items_to_read, False, XA_CARDINAL, &actual_type,
                           &actual_format, &nitems_read, &bytes_after,
                           &ret_data);

        if (nitems_read) {
            if (!bytes_after) {
                return_values = (Atom *) ret_data;
                edges->left =
                    edges->left >
                    (int)return_values[0] ? edges->left : (int)return_values[0];
                edges->right =
                    edges->right > (int)return_values[1] ? edges->right : (int)
                    return_values[1];
                edges->top =
                    edges->top >
                    (int)return_values[2] ? edges->top : (int)return_values[2];
                edges->bottom =
                    edges->bottom >
                    (int)return_values[3] ? edges->bottom : (int)
                    return_values[3];
            } else {
                fprintf(stderr, "Getting taskbar size, property too large.\n");
                retval = 1;
            }
        } else {
            /* Assuming there will never be a taskbar that is the child of
             * another taskbar. */
            retval =
                search_windows_for_taskbars(dpy, children[i], wm_strut_partial,
                                            edges);
        }

        XFree(ret_data);
    }

    return retval;
}

int strut_partial_supported(Display * dpy, Window root_win,
                            Atom wm_strut_partial)
{
    Atom *return_values;
    Atom actual_type, supported;
    int actual_format, num_items_to_read = 100;
    int retval = 0;
    unsigned i;
    unsigned long nitems_read = 0, bytes_after;
    unsigned char *ret_data;

    supported = XInternAtom(dpy, "_NET_SUPPORTED", True);
    if (supported == None) {
        goto exit;
    }

    XGetWindowProperty(dpy, root_win, supported, 0, num_items_to_read,
                       False, XA_ATOM, &actual_type, &actual_format,
                       &nitems_read, &bytes_after, &ret_data);

    if (nitems_read) {
        if (!bytes_after) {
            return_values = (Atom *) ret_data;
            for (i = 0; i < nitems_read; ++i) {
                if (return_values[i] == wm_strut_partial) {
                    retval = 1;
                    break;
                }
            }
        } else {
            fprintf(stderr, "More supported EWMH Atoms than I accounted for\n");
        }
    }

    XFree(ret_data);

exit:
    return retval;
}

struct taskbar_sizes get_taskbar_size(Display * dpy, Window root_win)
{
    Atom wm_strut_partial;
    struct taskbar_sizes ret_edges = { 0, 0, 0, 0 };

    wm_strut_partial = XInternAtom(dpy, "_NET_WM_STRUT_PARTIAL", True);
    if (wm_strut_partial == None) {
        goto defaults;
    }

    if (!strut_partial_supported(dpy, root_win, wm_strut_partial)) {
        goto defaults;
    }

    if (search_windows_for_taskbars(dpy, root_win,
                                    wm_strut_partial, &ret_edges)) {
        goto defaults;
    }

    return ret_edges;

defaults:

    /* Set some defaults as a guess */
    fprintf(stderr,
            "Error finding _NET_WM_STRUT_PARTIAL atom - setting defaults\n"
            "of sigle taskbar at the bottom of 20 pixel\n");
    ret_edges.top = 20;

    return ret_edges;
}

/*
 * This reads the workarea directly, which avoids the recursive search for
 * which output I'm on and for what taskbars are around.
 *
 * There are problems with this:
 *      a) In some wm's (e.g. pekwm) the workarea is the entirety of both
 *         monitors when have multiple monitors. This means everything
 *         acts on the larger workarea, which is generally not what I
 *         want.
 *
 *      b) In other wm's (e.g. i3, awesome) the workarea is not set.
 *         I then have to fall back to the default.
 */
int read_workarea_direct(Display * dpy, Window root_win,
                         XWindowChanges * workarea)
{
    int retval = 1;
    Atom *return_values;
    Atom workarea_atom, actual_type;
    int actual_format, num_items_to_read = 100;
    unsigned long nitems_read = 0, bytes_after;
    unsigned char *ret_data;

    workarea_atom = XInternAtom(dpy, "_NET_WORKAREA", True);
    if (workarea_atom == None) {
        return 1;
    }

    XGetWindowProperty(dpy, root_win, workarea_atom, 0, num_items_to_read,
                       False, XA_CARDINAL, &actual_type, &actual_format,
                       &nitems_read, &bytes_after, &ret_data);

    if (actual_type == None) {
        goto free_and_close;
    }

    if (nitems_read) {
        if (!bytes_after) {
            retval = 0;
            return_values = (Atom *) ret_data;
            workarea->x = return_values[0];
            workarea->y = return_values[1];
            workarea->width = return_values[2];
            workarea->height = return_values[3];
        } else {
            fprintf(stderr, "More data than I accounted for\n");
        }
    }

free_and_close:
    XFree(ret_data);

    return retval;
}

int find_workarea(Display * dpy, Window root_win, XWindowChanges * workarea,
                  XWindowChanges * focussed_geom)
{
    int i;
    struct taskbar_sizes edges_reserved = { 0, 0, 0, 0 };
    XRRScreenResources *my_resources;
    XRRCrtcInfo *my_crtc;

    /* First try to read the ewhm WORKAREA hint. */
    if (!read_workarea_direct(dpy, root_win, workarea)) {
        return 0;
    }

    /* If that didn't work, get the size from the output and search all windows
     * for the _NET_WM_STRUT_PARTIAL hint */
    edges_reserved = get_taskbar_size(dpy, root_win);

    my_resources = XRRGetScreenResources(dpy, root_win);
    if (!my_resources) {
        fprintf(stderr, "Error getting resources.\n");
        return 1;
    }

    /* Find the size of the screen the focussed window is on. */
    for (i = 0; i < my_resources->ncrtc; ++i) {
        my_crtc = XRRGetCrtcInfo(dpy, my_resources, my_resources->crtcs[i]);
        if (!my_crtc) {
            continue;
        }

        if (my_crtc->x < focussed_geom->x
            && my_crtc->y < focussed_geom->y
            && my_crtc->x + (int)my_crtc->width > focussed_geom->x
            && my_crtc->y + (int)my_crtc->height > focussed_geom->y) {
            workarea->x = my_crtc->x + edges_reserved.left;
            workarea->y = my_crtc->y + edges_reserved.top;
            workarea->width =
                my_crtc->width - edges_reserved.left - edges_reserved.right;
            workarea->height =
                my_crtc->height - edges_reserved.top - edges_reserved.bottom;
            XRRFreeCrtcInfo(my_crtc);
            break;
        }

        XRRFreeCrtcInfo(my_crtc);
    }
    XRRFreeScreenResources(my_resources);

    if (workarea->width == 0 || workarea->height == 0) {
        /* Some time in the future, look at the other corners and use the first
         * monitor we find that has a corner on it.
         * For now, just complain and exit. */
        fprintf(stderr,
                "Top left corner is off all monitors.\nExiting without doing anything.\n");
        return 1;
    }

    return 0;
}

/* Main program:
 *      Open the connection to the X server.
 *      Read in the geometry of the root window.
 *      Find the taskbar heights.
 *      Call the function specified by the argument list.
 */
int main(int argc, char *argv[])
{
    Display *dpy = NULL;
    Window root_win, current = 0;
    int still_exists = 0;
    XWindowChanges workarea = { 0, 0, 0, 0, 0, 0, 0 };
    XWindowChanges focussed_geom = { 0, 0, 0, 0, 0, 0, 0 };
    XWindowChanges new_geom = { 0, 0, 0, 0, 0, 0, 0 };
    XWindowChanges(*get_new_size) (XWindowChanges, XWindowChanges);
    void (*apply_changes) (Display *, Window, XWindowChanges);

    /* Argument parsing - either motion or resize command */
    if (argc == 3 && !strcmp(argv[1], "snap_to")) {
        get_new_size = find_snap_function(argv[2]);
        apply_changes = &ApplyMove;
    } else if (argc == 3 && !strcmp(argv[1], "resize_to")) {
        get_new_size = find_resize_function(argv[2]);
        apply_changes = &ApplyResize;
    } else {
        /* Not valid arguments - print usage and do nothing */
        printf("Usage: %s [[snap_to position] | [resize_to position]]\n",
               argv[0]);
        return 1;
    }

    if (!get_new_size) {
        fprintf(stderr, "Unknown size/position: %s\n", argv[2]);
        return 2;
    }

    /* Make sure the display opened correctly */
    dpy = XOpenDisplay(NULL);
    if (!dpy) {
        fprintf(stderr, "Error opening display\n");
        return 1;
    }

    root_win = DefaultRootWindow(dpy);

    XGetInputFocus(dpy, &current, &still_exists);
    /* Check */
    focussed_geom = find_geom(dpy, current);
    /* Check */

    if (find_workarea(dpy, root_win, &workarea, &focussed_geom)) {
        /* Some error trying to get the workarea */
        goto close_display;
    }

    /*
     *  Here the workarea structure contains the geometry of the workarea.
     *  The focussed_geom structure contains the geometry of the current
     *  window.
     */
    new_geom = get_new_size(focussed_geom, workarea);
    apply_changes(dpy, current, new_geom);

close_display:
    XCloseDisplay(dpy);
    return 0;
}
