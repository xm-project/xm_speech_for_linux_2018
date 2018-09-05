; Auto-generated. Do not edit!


(cl:in-package xm_speech-srv)


;//! \htmlinclude xm_Speech-request.msg.html

(cl:defclass <xm_Speech-request> (roslisp-msg-protocol:ros-message)
  ((audio_data
    :reader audio_data
    :initarg :audio_data
    :type cl:string
    :initform ""))
)

(cl:defclass xm_Speech-request (<xm_Speech-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <xm_Speech-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'xm_Speech-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name xm_speech-srv:<xm_Speech-request> is deprecated: use xm_speech-srv:xm_Speech-request instead.")))

(cl:ensure-generic-function 'audio_data-val :lambda-list '(m))
(cl:defmethod audio_data-val ((m <xm_Speech-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:audio_data-val is deprecated.  Use xm_speech-srv:audio_data instead.")
  (audio_data m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <xm_Speech-request>) ostream)
  "Serializes a message object of type '<xm_Speech-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'audio_data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'audio_data))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <xm_Speech-request>) istream)
  "Deserializes a message object of type '<xm_Speech-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'audio_data) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'audio_data) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<xm_Speech-request>)))
  "Returns string type for a service object of type '<xm_Speech-request>"
  "xm_speech/xm_SpeechRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech-request)))
  "Returns string type for a service object of type 'xm_Speech-request"
  "xm_speech/xm_SpeechRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<xm_Speech-request>)))
  "Returns md5sum for a message object of type '<xm_Speech-request>"
  "b0db70cd6474af67f2b501ae6232f04a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'xm_Speech-request)))
  "Returns md5sum for a message object of type 'xm_Speech-request"
  "b0db70cd6474af67f2b501ae6232f04a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<xm_Speech-request>)))
  "Returns full string definition for message of type '<xm_Speech-request>"
  (cl:format cl:nil "string audio_data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'xm_Speech-request)))
  "Returns full string definition for message of type 'xm_Speech-request"
  (cl:format cl:nil "string audio_data~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <xm_Speech-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'audio_data))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <xm_Speech-request>))
  "Converts a ROS message object to a list"
  (cl:list 'xm_Speech-request
    (cl:cons ':audio_data (audio_data msg))
))
;//! \htmlinclude xm_Speech-response.msg.html

(cl:defclass <xm_Speech-response> (roslisp-msg-protocol:ros-message)
  ((sr_text
    :reader sr_text
    :initarg :sr_text
    :type cl:string
    :initform ""))
)

(cl:defclass xm_Speech-response (<xm_Speech-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <xm_Speech-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'xm_Speech-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name xm_speech-srv:<xm_Speech-response> is deprecated: use xm_speech-srv:xm_Speech-response instead.")))

(cl:ensure-generic-function 'sr_text-val :lambda-list '(m))
(cl:defmethod sr_text-val ((m <xm_Speech-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:sr_text-val is deprecated.  Use xm_speech-srv:sr_text instead.")
  (sr_text m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <xm_Speech-response>) ostream)
  "Serializes a message object of type '<xm_Speech-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'sr_text))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'sr_text))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <xm_Speech-response>) istream)
  "Deserializes a message object of type '<xm_Speech-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sr_text) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'sr_text) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<xm_Speech-response>)))
  "Returns string type for a service object of type '<xm_Speech-response>"
  "xm_speech/xm_SpeechResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech-response)))
  "Returns string type for a service object of type 'xm_Speech-response"
  "xm_speech/xm_SpeechResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<xm_Speech-response>)))
  "Returns md5sum for a message object of type '<xm_Speech-response>"
  "b0db70cd6474af67f2b501ae6232f04a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'xm_Speech-response)))
  "Returns md5sum for a message object of type 'xm_Speech-response"
  "b0db70cd6474af67f2b501ae6232f04a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<xm_Speech-response>)))
  "Returns full string definition for message of type '<xm_Speech-response>"
  (cl:format cl:nil "string sr_text~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'xm_Speech-response)))
  "Returns full string definition for message of type 'xm_Speech-response"
  (cl:format cl:nil "string sr_text~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <xm_Speech-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'sr_text))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <xm_Speech-response>))
  "Converts a ROS message object to a list"
  (cl:list 'xm_Speech-response
    (cl:cons ':sr_text (sr_text msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'xm_Speech)))
  'xm_Speech-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'xm_Speech)))
  'xm_Speech-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech)))
  "Returns string type for a service object of type '<xm_Speech>"
  "xm_speech/xm_Speech")