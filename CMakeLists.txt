# %Tag(FULLTEXT)%
cmake_minimum_required(VERSION 2.8.3)
project(xm_speech)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  message_generation
)

## Generate services in the 'srv' folder
add_service_files(
   FILES
   xm_Speech.srv
   xm_Speech_meaning.srv
   xm_Speech_tts.srv
)

## Generate added messages and services with any dependencies listed here
generate_messages(
   DEPENDENCIES
   std_msgs
 )

catkin_package()

# include_directories(include)
include_directories(
  include     ##放置讯飞头文件
  ${catkin_INCLUDE_DIRS}
)

link_directories(
  lib         ##放置讯飞链接库
)

## Declare a C++ executable
add_executable(xm_speech_server src/xm_speech_server.cpp)
add_executable(tts_sample src/tts_sample.cpp)

## Add cmake target dependencies of the executable
## same as for the library above
add_dependencies(xm_speech_server xm_speech_gencpp)
add_dependencies(tts_sample xm_speech_gencpp)


## Specify libraries to link a library or executable target against
target_link_libraries(xm_speech_server
   ${catkin_LIBRARIES}
   libmsc.so   ##
 )

target_link_libraries(tts_sample
   ${catkin_LIBRARIES}
   libmsctts.so   ##
 )

#set (CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS}  -g ")
#set (CMAKE_VERBOSE_MAKEFILE ON)


