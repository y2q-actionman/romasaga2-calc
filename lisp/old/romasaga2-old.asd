(defsystem :romasaga2-old
  :description "ロマサガ2 閃き計算機 古いコード片"
  :license "LLGPL"
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :depends-on (:romasaga2 :paren6)
  :serial t
  :components
  ((:file "old_util")
   (:file "hirameki-type__old")
   ))
