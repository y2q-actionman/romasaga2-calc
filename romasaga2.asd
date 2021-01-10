(defsystem :romasaga2
  :description ""
  :license ""
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :depends-on ()
  :components
  ((:module "src"
    :serial t
    :components
    ((:file "package")
     (:file "waza-list")
     (:file "hirameki-type")
     (:file "calc")
     )))
  )
