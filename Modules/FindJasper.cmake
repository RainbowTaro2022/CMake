# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

#[=======================================================================[.rst:
FindJasper
----------

Try to find the Jasper JPEG2000 library

Once done this will define

::

  JASPER_FOUND - system has Jasper
  JASPER_INCLUDE_DIR - the Jasper include directory
  JASPER_LIBRARIES - the libraries needed to use Jasper
  JASPER_VERSION_STRING - the version of Jasper found (since CMake 2.8.8)
#]=======================================================================]

find_path(JASPER_INCLUDE_DIR jasper/jasper.h)
mark_as_advanced(JASPER_INCLUDE_DIR)

if(NOT JASPER_LIBRARIES)
  find_package(JPEG)
  find_library(JASPER_LIBRARY_RELEASE NAMES jasper libjasper)
  find_library(JASPER_LIBRARY_DEBUG NAMES jasperd)
  include(${CMAKE_CURRENT_LIST_DIR}/SelectLibraryConfigurations.cmake)
  select_library_configurations(JASPER)
endif()

if(JASPER_INCLUDE_DIR AND EXISTS "${JASPER_INCLUDE_DIR}/jasper/jas_config.h")
  file(STRINGS "${JASPER_INCLUDE_DIR}/jasper/jas_config.h" jasper_version_str REGEX "^#define[\t ]+JAS_VERSION[\t ]+\".*\".*")
  string(REGEX REPLACE "^#define[\t ]+JAS_VERSION[\t ]+\"([^\"]+)\".*" "\\1" JASPER_VERSION_STRING "${jasper_version_str}")
endif()

include(${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args(Jasper
                                  REQUIRED_VARS JASPER_LIBRARIES JASPER_INCLUDE_DIR JPEG_LIBRARIES
                                  VERSION_VAR JASPER_VERSION_STRING)

if(JASPER_FOUND)
  set(JASPER_LIBRARIES ${JASPER_LIBRARIES} ${JPEG_LIBRARIES})
endif()
