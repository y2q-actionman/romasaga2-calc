(in-package :romasaga2)

(ps:defpsmacro throw-js-error (error-object-class &rest error-object-args)
  `(ps:throw (ps:new (,error-object-class ,@error-object-args))))

(ps:defpsmacro ps-simple-error (string)
  `(throw-js-error -Error ,string))


(defmacro define-assoc-list (variable-name finder-function-name alist)
  "Defines an assoc list and a finder function.
This macro is for Parenscript-compatible alist definition."
  `(progn (defparameter ,variable-name
            ',alist)
          (defun ,finder-function-name (name)
            (or (cdr (assoc name ,variable-name))
                (error "'~A' was not found in ~A" name ',variable-name)))))

(ps:defpsmacro define-assoc-list (variable-name finder-function-name alist)
  `(progn
     (defparameter ,variable-name
       ,(loop for (k . v) in alist
           collect (string k) into ret
           collect v into ret
           finally (return (list* 'ps:create ret))))
     (defun ,finder-function-name (name)
       (or (ps:getprop ,variable-name name)
           (let ((varname ',variable-name))
             (ps-simple-error (+ "'" name "' was not found in " varname)))))))



(defun ps-compile-file-to-file (lisp-file-name)
  (let ((output-file-name (make-pathname :type "js" :defaults lisp-file-name)))
    (with-open-file (out output-file-name :direction :output :if-exists :supersede)
      (let ((ps:*parenscript-stream* out))
        (ps:ps-compile-file lisp-file-name)))
    output-file-name))
