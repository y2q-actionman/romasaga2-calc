(defsystem :romasaga2
  :description ""
  :license ""
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :depends-on (:parenscript :paren6 :alexandria :cl-ppcre)
  :serial t
  :components
  ((:file "package")
   (:file "util")
   (:file "waza-list")
   (:file "monster-level")
   (:file "generate-hirameki-type")
   (:file "hirameki-type")
   (:file "calc")
   (:file "main")))
