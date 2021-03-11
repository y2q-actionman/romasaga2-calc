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

(ps:defpsmacro first (list)
  `(elt ,list 0))

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


;;; very hacky 'const' implementation.
(ps::define-statement-operator define-constant (name value &key test documentation)
  (declare (ignore test))
  (let ((value (ps::ps-macroexpand value)))
    `(const ,(ps::ps-macroexpand name)
            ,@(list (ps::compile-expression value) documentation))))

(ps::defprinter const (var-name &optional (value (values) value?) docstring)
  (when docstring (ps::print-comment docstring))
  "const "(ps::psw (ps::symbol-to-js-string var-name))
  (when value? (ps::psw " = ") (ps::print-op-argument 'ps-js:= value)))


(defmacro define-assoc-list (variable-name finder-function-name alist &optional documentation)
  "Defines an assoc list and a finder function.
This macro is for Parenscript-compatible alist definition."
  `(progn (define-constant ,variable-name
              ',alist
            :test 'tree-equal
            :documentation ,documentation)
          (defun ,finder-function-name (name &optional (errorp t))
            (let ((cons (assoc name ,variable-name)))
              (if cons
                  (cdr cons)
                  (if errorp (error "'~A' was not found in ~A" name ',variable-name)))))))

(ps:defpsmacro define-assoc-list (variable-name finder-function-name alist &optional documentation)
  `(progn
     (define-constant ,variable-name
       ,(loop for (k . v) in alist
           collect (string k) into ret
           collect `',v into ret
           finally (return (list* 'ps:create ret)))
       :documentation ,documentation)
     (defun ,finder-function-name (name &optional (errorp t))
       (if (ps:chain ,variable-name (has-own-property name))
           (ps:getprop ,variable-name name)
           (if errorp
               (ps-simple-error (+ "'" name "' was not found in " ',variable-name)))))))

(defun ps-compile-file-to-file (lisp-file-name)
  "For debug"
  (let ((output-file-name (make-pathname :type "js" :defaults lisp-file-name)))
    (with-open-file (out output-file-name :direction :output :if-exists :supersede)
      (let ((ps:*parenscript-stream* out))
        (ps:ps-compile-file lisp-file-name)))
    output-file-name))


;;; For building 'romasaga2-name' package.

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun collect-tree-symbol (tree &optional (accumulator nil))
    "Walks TREE and collect distinct symbols."
    (typecase tree
      (null accumulator)
      (symbol (list* tree accumulator))
      (list (union (collect-tree-symbol (car tree) accumulator)
                   (collect-tree-symbol (cdr tree) accumulator)))
      (array (loop for i across tree
                do (setf accumulator (collect-tree-symbol i accumulator))
                finally (return accumulator)))
      (t accumulator))))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun import-and-export (symbols &optional (package *package*))
    "Calls `cl:import' and `cl:export'"
    (import symbols package)
    (export symbols package)))

(ps:defpsmacro import-and-export (&rest _)
  (declare (ignore _))
  nil)
