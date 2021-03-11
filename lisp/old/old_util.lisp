(in-package :romasaga2)

;;; Used in 'hirameki-type__old.lisp' only.
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
