;; Auto-generated. Do not edit!


(when (boundp 'xm_speech::xm_Speech)
  (if (not (find-package "XM_SPEECH"))
    (make-package "XM_SPEECH"))
  (shadow 'xm_Speech (find-package "XM_SPEECH")))
(unless (find-package "XM_SPEECH::XM_SPEECH")
  (make-package "XM_SPEECH::XM_SPEECH"))
(unless (find-package "XM_SPEECH::XM_SPEECHREQUEST")
  (make-package "XM_SPEECH::XM_SPEECHREQUEST"))
(unless (find-package "XM_SPEECH::XM_SPEECHRESPONSE")
  (make-package "XM_SPEECH::XM_SPEECHRESPONSE"))

(in-package "ROS")





(defclass xm_speech::xm_SpeechRequest
  :super ros::object
  :slots (_audio_data ))

(defmethod xm_speech::xm_SpeechRequest
  (:init
   (&key
    ((:audio_data __audio_data) "")
    )
   (send-super :init)
   (setq _audio_data (string __audio_data))
   self)
  (:audio_data
   (&optional __audio_data)
   (if __audio_data (setq _audio_data __audio_data)) _audio_data)
  (:serialization-length
   ()
   (+
    ;; string _audio_data
    4 (length _audio_data)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _audio_data
       (write-long (length _audio_data) s) (princ _audio_data s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _audio_data
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _audio_data (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass xm_speech::xm_SpeechResponse
  :super ros::object
  :slots (_sr_text ))

(defmethod xm_speech::xm_SpeechResponse
  (:init
   (&key
    ((:sr_text __sr_text) "")
    )
   (send-super :init)
   (setq _sr_text (string __sr_text))
   self)
  (:sr_text
   (&optional __sr_text)
   (if __sr_text (setq _sr_text __sr_text)) _sr_text)
  (:serialization-length
   ()
   (+
    ;; string _sr_text
    4 (length _sr_text)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _sr_text
       (write-long (length _sr_text) s) (princ _sr_text s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _sr_text
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _sr_text (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass xm_speech::xm_Speech
  :super ros::object
  :slots ())

(setf (get xm_speech::xm_Speech :md5sum-) "b0db70cd6474af67f2b501ae6232f04a")
(setf (get xm_speech::xm_Speech :datatype-) "xm_speech/xm_Speech")
(setf (get xm_speech::xm_Speech :request) xm_speech::xm_SpeechRequest)
(setf (get xm_speech::xm_Speech :response) xm_speech::xm_SpeechResponse)

(defmethod xm_speech::xm_SpeechRequest
  (:response () (instance xm_speech::xm_SpeechResponse :init)))

(setf (get xm_speech::xm_SpeechRequest :md5sum-) "b0db70cd6474af67f2b501ae6232f04a")
(setf (get xm_speech::xm_SpeechRequest :datatype-) "xm_speech/xm_SpeechRequest")
(setf (get xm_speech::xm_SpeechRequest :definition-)
      "string audio_data
---
string sr_text

")

(setf (get xm_speech::xm_SpeechResponse :md5sum-) "b0db70cd6474af67f2b501ae6232f04a")
(setf (get xm_speech::xm_SpeechResponse :datatype-) "xm_speech/xm_SpeechResponse")
(setf (get xm_speech::xm_SpeechResponse :definition-)
      "string audio_data
---
string sr_text

")



(provide :xm_speech/xm_Speech "b0db70cd6474af67f2b501ae6232f04a")


