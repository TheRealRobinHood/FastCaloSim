include(FeatureSummary)
set_package_properties(
    ONNXRuntime PROPERTIES
    URL "https://onnxruntime.ai/"
    DESCRIPTION "Machine learning runtime")

# Optionally, you can set a ONNX root directory here to help cmake find the library
# Should not be necessary in any standard installations
set(ONNXRuntime_ROOT_DIR " " CACHE PATH "Root to search for ONNXRuntime")

find_package(PkgConfig)
pkg_check_modules(PC_ONNXRuntime QUIET libonnxruntime)

find_library(
    ONNXRuntime_LIBRARY
    NAMES onnxruntime
    PATHS ${ONNXRuntime_ROOT_DIR}
    PATH_SUFFIXES lib lib32 lib64
    HINTS ${PC_ONNXRuntime_LIBRARY_DIRS})

find_path(
    ONNXRuntime_INCLUDE_DIR onnxruntime_cxx_api.h
    NAMES core/session/onnxruntime_cxx_api.h onnxruntime_cxx_api.h
    REQUIRED
    PATHS ${ONNXRuntime_ROOT_DIR}
    PATH_SUFFIXES onnxruntime include include/onnxruntime onnxruntime/core/session 
                  include/onnxruntime/core/session
    HINTS ${PC_ONNXRuntime_INCLUDE_DIRS})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    ONNXRuntime REQUIRED_VARS ONNXRuntime_INCLUDE_DIR ONNXRuntime_LIBRARY)

if(ONNXRuntime_FOUND)
    set(ONNXRuntime_INCLUDE_DIRS ${ONNXRuntime_INCLUDE_DIR})
    if(EXISTS "${ONNXRuntime_INCLUDE_DIR}/core/session")
        set(ONNXRuntime_INCLUDE_DIRS ${ONNXRuntime_INCLUDE_DIRS} ${ONNXRuntime_INCLUDE_DIR}/core/session)
    endif()
    set(ONNXRuntime_LIBRARIES "${ONNXRuntime_LIBRARY}")
    if(NOT TARGET ONNXRuntime::ONNXRuntime)
        add_library(ONNXRuntime::ONNXRuntime UNKNOWN IMPORTED)
    endif()
    set_target_properties(
        ONNXRuntime::ONNXRuntime PROPERTIES INTERFACE_INCLUDE_DIRECTORIES
                                            "${ONNXRuntime_INCLUDE_DIRS}")
    set_target_properties(
        ONNXRuntime::ONNXRuntime
        PROPERTIES IMPORTED_LINK_INTERFACE_LANGUAGES "C"
                   IMPORTED_LOCATION "${ONNXRuntime_LIBRARY}")
    mark_as_advanced(ONNXRuntime_INCLUDE_DIRS ONNXRuntime_LIBRARY)
endif()

mark_as_advanced(ONNXRuntime_ROOT_DIR)
