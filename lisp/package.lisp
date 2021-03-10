(in-package :cl-user)

(defpackage :romasaga2
  (:use #:cl)
  (:use #:alexandria)
  (:export
   ;; For HTML and JS output.
   #:print-all-waza-name-for-html-datalist
   #:print-all-waza-name-for-html-dojo
   #:make-romasaga2-js
   ;; For romasaga2-user
   #:print-all))

(in-package :romasaga2)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defvar *romasaga2-name-package*
    (make-package '#:romasaga2-name :use nil)))
