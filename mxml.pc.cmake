prefix=@CMAKE_INSTALL_PREFIX@
exec_prefix=${prefix}
libdir=@CMAKE_INSTALL_FULL_LIBDIR@
includedir=@CMAKE_INSTALL_FULL_INCLUDEDIR@

Name: Mini-XML
Description: Lightweight XML support library
Version: @PROJECT_VERSION@
Libs: -L${libdir} -lmxml
Cflags: -I${includedir}
