# The following lines of boilerplate have to be in your project's
# CMakeLists in this exact order for cmake to work correctly
cmake_minimum_required(VERSION 3.16)

set(MROS2_PATH $ENV{MROS2_PATH})
set(EXTRA_COMPONENT_DIRS ${MROS2_PATH}/components ${MROS2_PATH}/workspace/common)

add_compile_options(-w)

include($ENV{IDF_PATH}/tools/cmake/project.cmake)
project(pub_bool)