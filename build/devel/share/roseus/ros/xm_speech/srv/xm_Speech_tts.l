;; Auto-generated. Do not edit!


(when (boundp 'xm_speech::xm_Speech_tts)
  (if (not (find-package "XM_SPEECH"))
    (make-package "XM_SPEECH"))
  (shadow 'xm_Speech_tts (find-package "XM_SPEECH")))
(unless (find-package "XM_SPEECH::XM_SPEECH_TTS")
  (make-package "XM_SPEECH::XM_SPEECH_TTS"))
(unless (find-package "XM_SPEECH::XM_SPEECH_TTSREQUEST")
  (make-package "XM_SPEECH::XM_SPEECH_TTSREQUEST"))
(unless (find-package "XM_SPEECH::XM_SPEECH_TTSRESPONSE")
  (make-package "XM_SPEECH::XM_SPEECH_TTSRESPONSE"))

(in-package "ROS")





(defclass xm_speech::xm_Speech_ttsRequest
  :super ros::object
  :slots (_tts_text ))

(defmethod xm_speech::xm_Speech_ttsRequest
  (:init
   (&key
    ((:tts_text __tts_text) "")
    )
   (send-super :init)
   (setq _tts_text (string __tts_text))
   self)
  (:tts_text
   (&optional __tts_text)
   (if __tts_text (setq _tts_text __tts_text)) _tts_text)
  (:serialization-length
   ()
   (+
    ;; string _tts_text
    4 (length _tts_text)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _tts_text
       (write-long (length _tts_text) s) (princ _tts_text s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _tts_text
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _tts_text (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass xm_speech::xm_Speech_ttsResponse
  :super ros::object
  :slots (_flag ))

(defmethod xm_speech::xm_Speech_ttsResponse
  (:init
   (&key
    ((:flag __flag) 0)
    )
   (send-super :init)
   (setq _flag (round __flag))
   self)
  (:flag
   (&optional __flag)
   (if __flag (setq _flag __flag)) _flag)
  (:serialization-length
   ()
   (+
    ;; uint8 _flag
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _flag
       (write-byte _flag s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _flag
     (setq _flag (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass xm_speech::xm_Speech_tts
  :super ros::object
  :slots ())

(setf (get xm_speech::xm_Speech_tts :md5sum-) "6c25999b48630da1ebe398b2997ee386")
(setf (get xm_speech::xm_Speech_tts :datatype-) "xm_speech/xm_Speech_tts")
(setf (get xm_speech::xm_Speech_tts :request) xm_speech::xm_Speech_ttsRequest)
(setf (get xm_speech::xm_Speech_tts :response) xm_speech::xm_Speech_ttsResponse)

(defmethod xm_speech::xm_Speech_ttsRequest
  (:response () (instance xm_speech::xm_Speech_ttsResponse :init)))

(setf (get xm_speech::xm_Speech_ttsRequest :md5sum-) "6c25999b48630da1ebe398b2997ee386")
(setf (get xm_speech::xm_Speech_ttsRequest :datatype-) "xm_speech/xm_Speech_ttsRequest")
(setf (get xm_speech::xm_Speech_ttsRequest :definition-)
      "string tts_text
---
uint8 flag

")

(setf (get xm_speech::xm_Speech_ttsResponse :md5sum-) "6c25999b48630da1ebe398b2997ee386")
(setf (get xm_speech::xm_Speech_ttsResponse :datatype-) "xm_speech/xm_Speech_ttsResponse")
(setf (get xm_speech::xm_Speech_ttsResponse :definition-)
      "string tts_text
---
uint8 flag

")



(provide :xm_speech/xm_Speech_tts "6c25999b48630da1ebe398b2997ee386")


