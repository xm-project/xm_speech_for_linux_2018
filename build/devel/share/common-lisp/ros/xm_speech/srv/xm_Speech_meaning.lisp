; Auto-generated. Do not edit!


(cl:in-package xm_speech-srv)


;//! \htmlinclude xm_Speech_meaning-request.msg.html

(cl:defclass <xm_Speech_meaning-request> (roslisp-msg-protocol:ros-message)
  ((command
    :reader command
    :initarg :command
    :type cl:fixnum
    :initform 0))
)

(cl:defclass xm_Speech_meaning-request (<xm_Speech_meaning-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <xm_Speech_meaning-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'xm_Speech_meaning-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name xm_speech-srv:<xm_Speech_meaning-request> is deprecated: use xm_speech-srv:xm_Speech_meaning-request instead.")))

(cl:ensure-generic-function 'command-val :lambda-list '(m))
(cl:defmethod command-val ((m <xm_Speech_meaning-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:command-val is deprecated.  Use xm_speech-srv:command instead.")
  (command m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <xm_Speech_meaning-request>) ostream)
  "Serializes a message object of type '<xm_Speech_meaning-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'command)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <xm_Speech_meaning-request>) istream)
  "Deserializes a message object of type '<xm_Speech_meaning-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'command)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<xm_Speech_meaning-request>)))
  "Returns string type for a service object of type '<xm_Speech_meaning-request>"
  "xm_speech/xm_Speech_meaningRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech_meaning-request)))
  "Returns string type for a service object of type 'xm_Speech_meaning-request"
  "xm_speech/xm_Speech_meaningRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<xm_Speech_meaning-request>)))
  "Returns md5sum for a message object of type '<xm_Speech_meaning-request>"
  "844b59f8509f804f0390d479af52f9d8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'xm_Speech_meaning-request)))
  "Returns md5sum for a message object of type 'xm_Speech_meaning-request"
  "844b59f8509f804f0390d479af52f9d8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<xm_Speech_meaning-request>)))
  "Returns full string definition for message of type '<xm_Speech_meaning-request>"
  (cl:format cl:nil "uint8 command~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'xm_Speech_meaning-request)))
  "Returns full string definition for message of type 'xm_Speech_meaning-request"
  (cl:format cl:nil "uint8 command~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <xm_Speech_meaning-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <xm_Speech_meaning-request>))
  "Converts a ROS message object to a list"
  (cl:list 'xm_Speech_meaning-request
    (cl:cons ':command (command msg))
))
;//! \htmlinclude xm_Speech_meaning-response.msg.html

(cl:defclass <xm_Speech_meaning-response> (roslisp-msg-protocol:ros-message)
  ((num
    :reader num
    :initarg :num
    :type cl:fixnum
    :initform 0)
   (action
    :reader action
    :initarg :action
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (target
    :reader target
    :initarg :target
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (name
    :reader name
    :initarg :name
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element ""))
   (object
    :reader object
    :initarg :object
    :type (cl:vector cl:string)
   :initform (cl:make-array 0 :element-type 'cl:string :initial-element "")))
)

(cl:defclass xm_Speech_meaning-response (<xm_Speech_meaning-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <xm_Speech_meaning-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'xm_Speech_meaning-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name xm_speech-srv:<xm_Speech_meaning-response> is deprecated: use xm_speech-srv:xm_Speech_meaning-response instead.")))

(cl:ensure-generic-function 'num-val :lambda-list '(m))
(cl:defmethod num-val ((m <xm_Speech_meaning-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:num-val is deprecated.  Use xm_speech-srv:num instead.")
  (num m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <xm_Speech_meaning-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:action-val is deprecated.  Use xm_speech-srv:action instead.")
  (action m))

(cl:ensure-generic-function 'target-val :lambda-list '(m))
(cl:defmethod target-val ((m <xm_Speech_meaning-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:target-val is deprecated.  Use xm_speech-srv:target instead.")
  (target m))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <xm_Speech_meaning-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:name-val is deprecated.  Use xm_speech-srv:name instead.")
  (name m))

(cl:ensure-generic-function 'object-val :lambda-list '(m))
(cl:defmethod object-val ((m <xm_Speech_meaning-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader xm_speech-srv:object-val is deprecated.  Use xm_speech-srv:object instead.")
  (object m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <xm_Speech_meaning-response>) ostream)
  "Serializes a message object of type '<xm_Speech_meaning-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'action))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'target))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'target))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'object))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((__ros_str_len (cl:length ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) ele))
   (cl:slot-value msg 'object))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <xm_Speech_meaning-response>) istream)
  "Deserializes a message object of type '<xm_Speech_meaning-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'num)) (cl:read-byte istream))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'action) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'action)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'target) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'target)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'name) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'name)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'object) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'object)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:aref vals i) __ros_str_idx) (cl:code-char (cl:read-byte istream))))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<xm_Speech_meaning-response>)))
  "Returns string type for a service object of type '<xm_Speech_meaning-response>"
  "xm_speech/xm_Speech_meaningResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech_meaning-response)))
  "Returns string type for a service object of type 'xm_Speech_meaning-response"
  "xm_speech/xm_Speech_meaningResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<xm_Speech_meaning-response>)))
  "Returns md5sum for a message object of type '<xm_Speech_meaning-response>"
  "844b59f8509f804f0390d479af52f9d8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'xm_Speech_meaning-response)))
  "Returns md5sum for a message object of type 'xm_Speech_meaning-response"
  "844b59f8509f804f0390d479af52f9d8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<xm_Speech_meaning-response>)))
  "Returns full string definition for message of type '<xm_Speech_meaning-response>"
  (cl:format cl:nil "uint8 num~%string[] action~%string[] target~%string[] name~%string[] object~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'xm_Speech_meaning-response)))
  "Returns full string definition for message of type 'xm_Speech_meaning-response"
  (cl:format cl:nil "uint8 num~%string[] action~%string[] target~%string[] name~%string[] object~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <xm_Speech_meaning-response>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'action) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'target) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'name) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'object) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4 (cl:length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <xm_Speech_meaning-response>))
  "Converts a ROS message object to a list"
  (cl:list 'xm_Speech_meaning-response
    (cl:cons ':num (num msg))
    (cl:cons ':action (action msg))
    (cl:cons ':target (target msg))
    (cl:cons ':name (name msg))
    (cl:cons ':object (object msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'xm_Speech_meaning)))
  'xm_Speech_meaning-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'xm_Speech_meaning)))
  'xm_Speech_meaning-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'xm_Speech_meaning)))
  "Returns string type for a service object of type '<xm_Speech_meaning>"
  "xm_speech/xm_Speech_meaning")