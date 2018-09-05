# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "xm_speech: 0 messages, 3 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(xm_speech_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" NAME_WE)
add_custom_target(_xm_speech_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "xm_speech" "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" ""
)

get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" NAME_WE)
add_custom_target(_xm_speech_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "xm_speech" "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" ""
)

get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" NAME_WE)
add_custom_target(_xm_speech_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "xm_speech" "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/xm_speech
)
_generate_srv_cpp(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/xm_speech
)
_generate_srv_cpp(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/xm_speech
)

### Generating Module File
_generate_module_cpp(xm_speech
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/xm_speech
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(xm_speech_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(xm_speech_generate_messages xm_speech_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_cpp _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_cpp _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_cpp _xm_speech_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(xm_speech_gencpp)
add_dependencies(xm_speech_gencpp xm_speech_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS xm_speech_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/xm_speech
)
_generate_srv_eus(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/xm_speech
)
_generate_srv_eus(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/xm_speech
)

### Generating Module File
_generate_module_eus(xm_speech
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/xm_speech
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(xm_speech_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(xm_speech_generate_messages xm_speech_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_eus _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_eus _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_eus _xm_speech_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(xm_speech_geneus)
add_dependencies(xm_speech_geneus xm_speech_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS xm_speech_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/xm_speech
)
_generate_srv_lisp(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/xm_speech
)
_generate_srv_lisp(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/xm_speech
)

### Generating Module File
_generate_module_lisp(xm_speech
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/xm_speech
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(xm_speech_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(xm_speech_generate_messages xm_speech_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_lisp _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_lisp _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_lisp _xm_speech_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(xm_speech_genlisp)
add_dependencies(xm_speech_genlisp xm_speech_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS xm_speech_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/xm_speech
)
_generate_srv_nodejs(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/xm_speech
)
_generate_srv_nodejs(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/xm_speech
)

### Generating Module File
_generate_module_nodejs(xm_speech
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/xm_speech
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(xm_speech_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(xm_speech_generate_messages xm_speech_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_nodejs _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_nodejs _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_nodejs _xm_speech_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(xm_speech_gennodejs)
add_dependencies(xm_speech_gennodejs xm_speech_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS xm_speech_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech
)
_generate_srv_py(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech
)
_generate_srv_py(xm_speech
  "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech
)

### Generating Module File
_generate_module_py(xm_speech
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(xm_speech_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(xm_speech_generate_messages xm_speech_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_py _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_tts.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_py _xm_speech_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/tornado/xm_speech_for_linux/src/xm_speech/srv/xm_Speech_meaning.srv" NAME_WE)
add_dependencies(xm_speech_generate_messages_py _xm_speech_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(xm_speech_genpy)
add_dependencies(xm_speech_genpy xm_speech_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS xm_speech_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/xm_speech)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/xm_speech
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(xm_speech_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/xm_speech)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/xm_speech
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(xm_speech_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/xm_speech)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/xm_speech
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(xm_speech_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/xm_speech)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/xm_speech
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(xm_speech_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/xm_speech
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(xm_speech_generate_messages_py std_msgs_generate_messages_py)
endif()
