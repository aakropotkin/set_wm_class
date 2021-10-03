#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>
#include <string.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>

  int
main( int argc, char * argv[], char ** envp )
{
  unsigned long  value        = -1;
  char         * terminatedAt = NULL;
  Display      * display      = NULL;
  XClassHint     class;
  Status         status;
  Window         window;
  
  if ( argc != 4 )
    {
      fprintf( stderr,
               "Usage: %s <window id> <window resource/app> <window class>\n",
               argv[0]
             );
      return EXIT_FAILURE;
    }

  window = strtoul( argv[1], & terminatedAt, 0 );
  if ( terminatedAt[0] != '\0' )
    {
      fprintf( stderr, "Could not parse window id: %s\n", argv[1] );
      return EXIT_FAILURE;
    }
  
  /* Fetch existing window class hint */
  display = XOpenDisplay( NULL );
  status = XGetClassHint( display, window, & class );
  if ( status == NULL )
    {
      fprintf( stderr, "Failed to fetch window class\n" );
      return EXIT_FAILURE;
    }
  
  /* Free existing class hint string, and replace it with provided hint. */
  XFree( class.res_class );
  class.res_class = strdup( argv[3] );
  if ( class.res_class == NULL )
    {
      fprintf( stderr, "Failed to duplicate string: \"%s\"\n", argv[3] );
      return EXIT_FAILURE;
    }


  XFree( class.res_name );
  class.res_name = strdup( argv[2] );
  if ( class.res_name == NULL )
    {
      fprintf( stderr, "Failed to duplicate string: \"%s\"\n", argv[2] );
      return EXIT_FAILURE;
    }

  printf( "Setting WM_CLASS of window %lu to \"%s\", \"%s\"\n",
          window, class.res_name, class.res_class
        );
  XSetClassHint( display, window, & class );
  
  XCloseDisplay( display );
  XFree( class.res_name );
  XFree( class.res_class );

  return EXIT_SUCCESS;
}
