; Auto-generated. Do not edit!


(cl:in-package xm_speech-srv)


;//! \htmlinclude xm_Speech_tts-request.msg.html

(cl:defclass <xm_Speech_tts-request> (roslisp-msg-protocol:ros-message)
  ((tts_text
    :reader tts_text
    :initarg :tts_text
    :type cl:string
    :initform ""))
)

(cl:defclass xm_Speech_tts-request (<xm_Speech_tts-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <xm_Speech_tts-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'xm_Speech_tts-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name xm_speech-srv:<xm_Speech_tts-request> is deprecated: use xm_speech-srv:xm_Speech_tts-request instead.")))

(cl:ensure-generic-function 'tts_text-val :lambda-list '(m))
(cl:defmethod tts_text-val ((m <xm_Speech_tts-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:tts_text-val is deprecated.  Use xm_speech-srv:tts_text instead.")
  (tts_text m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <xm_Speech_tts-request>) ostream)
  "Serializes a message object of type '<xm_Speech_tts-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'tts_text))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'tts_text))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <xm_Speech_tts-request>) istream)
  "Deserializes a message object of type '<xm_Speech_tts-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tts_text) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'tts_text) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<xm_Speech_tts-request>)))
  "Returns string type for a service object of type '<xm_Speech_tts-request>"
  "xm_speech/xm_Speech_ttsRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech_tts-request)))
  "Returns string type for a service object of type 'xm_Speech_tts-request"
  "xm_speech/xm_Speech_ttsRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<xm_Speech_tts-request>)))
  "Returns md5sum for a message object of type '<xm_Speech_tts-request>"
  "6c25999b48630da1ebe398b2997ee386")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'xm_Speech_tts-request)))
  "Returns md5sum for a message object of type 'xm_Speech_tts-request"
  "6c25999b48630da1ebe398b2997ee386")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<xm_Speech_tts-request>)))
  "Returns full string definition for message of type '<xm_Speech_tts-request>"
  (cl:format cl:nil "string tts_text~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'xm_Speech_tts-request)))
  "Returns full string definition for message of type 'xm_Speech_tts-request"
  (cl:format cl:nil "string tts_text~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <xm_Speech_tts-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'tts_text))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <xm_Speech_tts-request>))
  "Converts a ROS message object to a list"
  (cl:list 'xm_Speech_tts-request
    (cl:cons ':tts_text (tts_text msg))
))
;//! \htmlinclude xm_Speech_tts-response.msg.html

(cl:defclass <xm_Speech_tts-response> (roslisp-msg-protocol:ros-message)
  ((flag
    :reader flag
    :initarg :flag
    :type cl:fixnum
    :initform 0))
)

(cl:defclass xm_Speech_tts-response (<xm_Speech_tts-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <xm_Speech_tts-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'xm_Speech_tts-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name xm_speech-srv:<xm_Speech_tts-response> is deprecated: use xm_speech-srv:xm_Speech_tts-response instead.")))

(cl:ensure-generic-function 'flag-val :lambda-list '(m))
(cl:defmethod flag-val ((m <xm_Speech_tts-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:flag-val is deprecated.  Use xm_speech-srv:flag instead.")
  (flag m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <xm_Speech_tts-response>) ostream)
  "Serializes a message object of type '<xm_Speech_tts-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'flag)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <xm_Speech_tts-response>) istream)
  "Deserializes a message object of type '<xm_Speech_tts-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'flag)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<xm_Speech_tts-response>)))
  "Returns string type for a service object of type '<xm_Speech_tts-response>"
  "xm_speech/xm_Speech_ttsResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech_tts-response)))
  "Returns string type for a service object of type 'xm_Speech_tts-response"
  "xm_speech/xm_Speech_ttsResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<xm_Speech_tts-response>)))
  "Returns md5sum for a message object of type '<xm_Speech_tts-response>"
  "6c25999b48630da1ebe398b2997ee386")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'xm_Speech_tts-response)))
  "Returns md5sum for a message object of type 'xm_Speech_tts-response"
  "6c25999b48630da1ebe398b2997ee386")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<xm_Speech_tts-response>)))
  "Returns full string definition for message of type '<xm_Speech_tts-response>"
  (cl:format cl:nil "uint8 flag~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'xm_Speech_tts-response)))
  "Returns full string definition for message of type 'xm_Speech_tts-response"
  (cl:format cl:nil "uint8 flag~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <xm_Speech_tts-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <xm_Speech_tts-response>))
  "Converts a ROS message object to a list"
  (cl:list 'xm_Speech_tts-response
    (cl:cons ':flag (flag msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'xm_Speech_tts)))
  'xm_Speech_tts-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'xm_Speech_tts)))
  'xm_Speech_tts-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech_tts)))
  "Returns string type for a service object of type '<xm_Speech_tts>"
  "xm_speech/xm_Speech_tts")