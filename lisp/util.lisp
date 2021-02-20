(in-package :romasaga2)

(defmacro define-assoc-list (variable-name finder-function-name alist)
  "Defines an assoc list and a finder function.
This macro is for Parenscript-compatible alist definition."
  `(progn (defparameter ,variable-name
            ',alist)
          (defun ,finder-function-name (name)
            (or (cdr (assoc name ,variable-name))
                (error "'~A' was not found in ~A" name ',variable-name)))))

(ps:defmacro+ps define-assoc-list (variable-name finder-function-name alist)
  `(progn
     (defparameter ,variable-name
       ,(loop for (k . v) in alist
           collect k into ret
           collect v into ret
           finally (return (list* 'ps:create ret))))
     (defun ,finder-function-name (name)
       (or (ps:getprop ,variable-name name)
           (error "'~A' was not found in ~A" name ',variable-name)))))
