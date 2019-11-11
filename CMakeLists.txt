cmake_minimum_required(VERSION 3.10)

project(mxml
    VERSION 1.1.0
    LANGUAGES C)

include(GNUInstallDirs)

find_package(Threads)

enable_testing()

configure_file(config.h.cmake ${CMAKE_CURRENT_SOURCE_DIR}/config.h @ONLY)

set(mxml_SRC
    mxml-attr.c
    mxml-get.c
    mxml-private.c
    mxml-string.c
    mxml-entity.c
    mxml-index.c
    mxml-search.c
    mxml-file.c
    mxml-node.c
    mxml-set.c
)

set(mxml_HDR
    config.h
    mxml-private.h
    mxml.h
)

add_library(mxml OBJECT ${mxml_SRC} ${mxml_HDR})
set_property(TARGET mxml PROPERTY POSITION_INDEPENDENT_CODE ON)

add_library(mxml_shared SHARED $<TARGET_OBJECTS:mxml>)
set_target_properties(mxml_shared PROPERTIES OUTPUT_NAME mxml)
set_target_properties(mxml_shared PROPERTIES
                      OUTPUT_NAME mxml
                      VERSION ${mxml_VERSION_MAJOR}.${mxml_VERSION_MINOR}
                      SOVERSION ${mxml_VERSION_MAJOR}
                      POSITION_INDEPENDENT_CODE ON
)

add_library(mxml_static STATIC $<TARGET_OBJECTS:mxml>)
set_target_properties(mxml_static PROPERTIES OUTPUT_NAME mxml)

add_executable(testmxml testmxml.c)
target_link_libraries(testmxml mxml_static)

add_test(NAME testxml_1 COMMAND testmxml ${CMAKE_SOURCE_DIR}/test.xml temp1s.xml temp1.xml)
add_test(NAME testxml_2 COMMAND testmxml temp1.xml temp2s.xml temp2.xml)

configure_file(mxml.pc.cmake mxml.pc @ONLY)

install(TARGETS mxml_shared mxml_static DESTINATION lib)
install(FILES mxml.h DESTINATION include)