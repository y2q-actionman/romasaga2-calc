(defsystem :romasaga2-generator
  :description "ロマサガ2 閃き計算機 一部データ生成"
  :license "LLGPL"
  :author "YOKOTA Yuki <y2q.actionman@gmail.com>"
  :depends-on (:cl-ppcre)
  :serial t
  :components
  ((:file "package")
   (:file "generate-hirameki-type")
   ))
