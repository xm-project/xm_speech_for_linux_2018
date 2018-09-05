;; Auto-generated. Do not edit!


(when (boundp 'xm_speech::xm_Speech_meaning)
  (if (not (find-package "XM_SPEECH"))
    (make-package "XM_SPEECH"))
  (shadow 'xm_Speech_meaning (find-package "XM_SPEECH")))
(unless (find-package "XM_SPEECH::XM_SPEECH_MEANING")
  (make-package "XM_SPEECH::XM_SPEECH_MEANING"))
(unless (find-package "XM_SPEECH::XM_SPEECH_MEANINGREQUEST")
  (make-package "XM_SPEECH::XM_SPEECH_MEANINGREQUEST"))
(unless (find-package "XM_SPEECH::XM_SPEECH_MEANINGRESPONSE")
  (make-package "XM_SPEECH::XM_SPEECH_MEANINGRESPONSE"))

(in-package "ROS")





(defclass xm_speech::xm_Speech_meaningRequest
  :super ros::object
  :slots (_command ))

(defmethod xm_speech::xm_Speech_meaningRequest
  (:init
   (&key
    ((:command __command) 0)
    )
   (send-super :init)
   (setq _command (round __command))
   self)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:serialization-length
   ()
   (+
    ;; uint8 _command
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _command
       (write-byte _command s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _command
     (setq _command (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass xm_speech::xm_Speech_meaningResponse
  :super ros::object
  :slots (_num _action _target _name _object ))

(defmethod xm_speech::xm_Speech_meaningResponse
  (:init
   (&key
    ((:num __num) 0)
    ((:action __action) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:target __target) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:name __name) (let (r) (dotimes (i 0) (push "" r)) r))
    ((:object __object) (let (r) (dotimes (i 0) (push "" r)) r))
    )
   (send-super :init)
   (setq _num (round __num))
   (setq _action __action)
   (setq _target __target)
   (setq _name __name)
   (setq _object __object)
   self)
  (:num
   (&optional __num)
   (if __num (setq _num __num)) _num)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:target
   (&optional __target)
   (if __target (setq _target __target)) _target)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:object
   (&optional __object)
   (if __object (setq _object __object)) _object)
  (:serialization-length
   ()
   (+
    ;; uint8 _num
    1
    ;; string[] _action
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _action)) 4
    ;; string[] _target
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _target)) 4
    ;; string[] _name
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _name)) 4
    ;; string[] _object
    (apply #'+ (mapcar #'(lambda (x) (+ 4 (length x))) _object)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _num
       (write-byte _num s)
     ;; string[] _action
     (write-long (length _action) s)
     (dolist (elem _action)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _target
     (write-long (length _target) s)
     (dolist (elem _target)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _name
     (write-long (length _name) s)
     (dolist (elem _name)
       (write-long (length elem) s) (princ elem s)
       )
     ;; string[] _object
     (write-long (length _object) s)
     (dolist (elem _object)
       (write-long (length elem) s) (princ elem s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _num
     (setq _num (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string[] _action
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _action (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _action i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _target
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _target (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _target i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _name
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _name (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _name i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;; string[] _object
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _object (make-list n))
     (dotimes (i n)
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setf (elt _object i) (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
     ))
   ;;
   self)
  )

(defclass xm_speech::xm_Speech_meaning
  :super ros::object
  :slots ())

(setf (get xm_speech::xm_Speech_meaning :md5sum-) "844b59f8509f804f0390d479af52f9d8")
(setf (get xm_speech::xm_Speech_meaning :datatype-) "xm_speech/xm_Speech_meaning")
(setf (get xm_speech::xm_Speech_meaning :request) xm_speech::xm_Speech_meaningRequest)
(setf (get xm_speech::xm_Speech_meaning :response) xm_speech::xm_Speech_meaningResponse)

(defmethod xm_speech::xm_Speech_meaningRequest
  (:response () (instance xm_speech::xm_Speech_meaningResponse :init)))

(setf (get xm_speech::xm_Speech_meaningRequest :md5sum-) "844b59f8509f804f0390d479af52f9d8")
(setf (get xm_speech::xm_Speech_meaningRequest :datatype-) "xm_speech/xm_Speech_meaningRequest")
(setf (get xm_speech::xm_Speech_meaningRequest :definition-)
      "uint8 command
---
uint8 num
string[] action
string[] target
string[] name
string[] object

")

(setf (get xm_speech::xm_Speech_meaningResponse :md5sum-) "844b59f8509f804f0390d479af52f9d8")
(setf (get xm_speech::xm_Speech_meaningResponse :datatype-) "xm_speech/xm_Speech_meaningResponse")
(setf (get xm_speech::xm_Speech_meaningResponse :definition-)
      "uint8 command
---
uint8 num
string[] action
string[] target
string[] name
string[] object

")



(provide :xm_speech/xm_Speech_meaning "844b59f8509f804f0390d479af52f9d8")


