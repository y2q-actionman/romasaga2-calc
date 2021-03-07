(in-package :romasaga2)

(ps:defpsmacro throw-js-error (error-object-class &rest error-object-args)
  `(ps:throw (ps:new (,error-object-class ,@error-object-args))))

(ps:defpsmacro ps-simple-error (string)
  `(throw-js-error -Error ,string))

(ps:defpsmacro ecase (keyform &body body)
  `(case ,keyform
     ,@body
     (otherwise (ps-simple-error "Fallen to ecase otherwise clause."))))


(ps:defpsmacro plusp (number)
  `(if (> ,number 0) t nil))

(ps:defpsmacro position (item sequence &key (start 0 start-supplied-p))
  (let ((ret (gensym)))
    `(let ((,ret (ps:chain ,sequence (index-of ,item ,@ (if start-supplied-p `(,start))))))
       (if (= ,ret -1) nil ,ret))))

(defun includes (list item)
  "For Parenscript 'includes' macro, which is expended to Array.includes()."
  (find item list))

(ps:defpsmacro includes (list item)
  `(ps:chain ,list (includes ,item)))

(ps:defpsmacro vector (&rest args)
  `(ps:array ,@args))


(defmacro define-assoc-list (variable-name finder-function-name alist)
  "Defines an assoc list and a finder function.
This macro is for Parenscript-compatible alist definition."
  `(progn (defparameter ,variable-name
            ',alist)
          (defun ,finder-function-name (name &optional (errorp t))
            (or (cdr (assoc name ,variable-name))
                (if errorp (error "'~A' was not found in ~A" name ',variable-name))))))

(ps:defpsmacro define-assoc-list (variable-name finder-function-name alist)
  `(progn
     (defparameter ,variable-name
       ,(loop for (k . v) in alist
           collect (string k) into ret
           collect `',v into ret
           finally (return (list* 'ps:create ret))))
     (defun ,finder-function-name (name &optional (errorp t))
       (or (ps:getprop ,variable-name name)
           (let ((varname ',variable-name))
             (if errorp (ps-simple-error (+ "'" name "' was not found in " varname))))))))


(ps:defpsmacro defstruct (name &body slots)
  ;; TODO: copier, predicate
  (let ((constructor-name (intern (format nil "make~A" name)))
        (reader-def nil)
        (writer-def nil)
        (slot-name-list nil)
        (slot-init-list nil))
    (loop for slot in slots
       do (destructuring-bind (slot-name &optional initial-value &key read-only type)
              (if (listp slot) slot (list slot))
            (declare (ignore type))
            (push slot-name slot-name-list)
            (push initial-value slot-init-list)
            (push `(get ,slot-name ()
                        (ps:getprop this ,slot-name ))
                  reader-def)
            (unless read-only
              (push `(set ,slot-name (value)
                          (setf (ps:getprop this ,slot-name) value))
                    writer-def)))
       finally
         (alexandria:nreversef slot-name-list)
         (alexandria:nreversef slot-init-list))
    `(progn
       (paren6:defclass6 (,name)
           (defun constructor (init-obj)
             (when (ps:undefined init-obj)
               (setf init-obj (ps:create)))
             ,@(loop for slot-name in slot-name-list
                 for slot-init in slot-init-list
                 collect
                    `(setf (ps:@ this ,slot-name)
                           (or (ps:@ init-obj ,slot-name)
                               ,slot-init)))
             this)
         ,@reader-def
         ,@writer-def)
       (defun ,constructor-name (&rest keyargs) ; defstruct 'make-' style function.
         (let ((initObj (ps:create))
               (k nil))
           (dolist (arg keyargs)
             (if (null k)
                 (setf k arg)
                 (setf (ps:getprop initObj k) arg
                       k nil)))
           (ps:new (,name initObj)))))))

#|
(ps:ps
 (defstruct test
  (id nil :type integer)
  (name "default name" :type symbol)
  (x)
  y))

(ps:ps (make-test :name "some name" :id 3))

|#


(defun ps-compile-file-to-file (lisp-file-name)
  "For debug"
  (let ((output-file-name (make-pathname :type "js" :defaults lisp-file-name)))
    (with-open-file (out output-file-name :direction :output :if-exists :supersede)
      (let ((ps:*parenscript-stream* out))
        (ps:ps-compile-file lisp-file-name)))
    output-file-name))
