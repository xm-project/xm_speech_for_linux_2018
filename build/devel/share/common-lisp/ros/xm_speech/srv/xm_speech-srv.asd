
(cl:in-package :asdf)

(defsystem "xm_speech-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "xm_Speech" :depends-on ("_package_xm_Speech"))
    (:file "_package_xm_Speech" :depends-on ("_package"))
    (:file "xm_Speech_meaning" :depends-on ("_package_xm_Speech_meaning"))
    (:file "_package_xm_Speech_meaning" :depends-on ("_package"))
    (:file "xm_Speech_tts" :depends-on ("_package_xm_Speech_tts"))
    (:file "_package_xm_Speech_tts" :depends-on ("_package"))
  ))