(defsystem :romasaga2
  :description "ロマサガ2 閃き計算機"
  :license "LLGPL"
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :depends-on (:parenscript :alexandria
                            #+() :paren6)
  :serial t
  :components
  ((:file "package")
   (:file "util")
   (:file "waza-list")
   (:file "monster-level")
   (:file "hirameki-type")
   (:file "initial-waza")
   (:file "calc")
   (:file "main")
   (:file "romasaga2-user")
   ))
