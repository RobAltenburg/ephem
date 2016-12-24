# ephem
A Chicken Scheme wrapper around the [libnova library](http://libnova.sourceforge.net/index.html) which is "a general purpose, double precision, Celestial Mechanics, Astrometry and Astrodynamics library" available under the GNU LPGL.

## Usage
Clone the repository and run chicken-install, then (use ephem).

Functions tend to be named the same as their libnova counterparts with dashes instead of underscores and dropping any "ln-" or "ln-get-" prefix.  Also, "->" is used instead of "to".  

Functions that take pointers to structures as arguments now take scheme record types defined in ephem-common.scm.

On exception is date functions where srfi-19 functions are used instead of the library functions.

## Status

The substantive parts of libnova have been implemented, but not everything has been tested for accuracy.  Use caution before relying on the results.

####### Notes

If chicken-install fails to find libnova, "export CSC_OPTIONS='-I/usr/local/include -L/usr/local/lib'" may help.





