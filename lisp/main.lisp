(in-package :romasaga2)


(defun print-waza-hirameki-result (waza-hirameki-result include-固有技)
  (loop for (waza prob from level unique-weapon) in waza-hirameki-result
     when (if include-固有技 t (not unique-weapon))
     do (format t " ~A	~5,3F	(from ~A)	(level ~A)	~@[~A~]~%"
                waza prob from level unique-weapon)))

(defun print-waza-list (waza-list
                        閃き済み技-list
                        enemy-waza-level
                        character-閃き可能-waza-list
                        include-固有技)
  (print-waza-hirameki-result
   (calc-waza-hirameki-list waza-list
                            閃き済み技-list
                            enemy-waza-level
                            character-閃き可能-waza-list)
   include-固有技))

(defun print-result (enemy-waza-level character-name
                     &key (include-固有技 nil)
                       (additional-閃き済み技-list nil))
  (let* ((閃き済み技-list (append additional-閃き済み技-list *閃き済み技-list*))
         (閃き-type-id (find-閃き-type-id-by-character-name character-name))
         (閃き可能-waza-list (find-閃き可能-waza-list-by-閃き-type-id 閃き-type-id)))
    (format t "~2&名前 ~A 閃きタイプ ~A (~A)~%"
            character-name 閃き-type-id (find-閃き-type-name-by-閃き-type-id 閃き-type-id))
    (loop for waza-type in +技種類-list+
       do (format t "~A~%" waza-type)
         (print-waza-list (find-技種類-技一覧-alist waza-type)
                          閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技))))

(defun print-all (enemy member-list enemy-waza-level additional-閃き済み技-list)
  (format t "~&敵 ~A Level ~D~2%" enemy enemy-waza-level)
  (loop for m in member-list
     do (print-result enemy-waza-level m
                      :include-固有技 nil
                      :additional-閃き済み技-list additional-閃き済み技-list))
  ;; 固有技
  (print-result enemy-waza-level 'レオン
                :additional-閃き済み技-list additional-閃き済み技-list
                :include-固有技 t))

;;; HTML output

(defun print-all-waza-name-for-html-datalist (&optional (stream *standard-output*))
  (format stream "<datalist id=\"all_waza_name\">~%")
  (dolist (waza-list (mapcar #'cdr +技種類-技一覧-alist+))
    (loop for waza in (rest waza-list)
       do (format stream "<option>~A<option> " waza))
    (terpri stream))
  (format stream "~&</datalist>"))


;;; JS output

(defparameter *required-ps-files*
  '("waza-list.lisp"
    "monster-level.lisp"
    "hirameki-type.lisp"
    "calc.lisp"
    ))

(defun make-romasaga2-js (&optional (output-file-name "romasaga2.js"))
  (with-open-file (out output-file-name :direction :output :if-exists :supersede)
    (let ((ps:*parenscript-stream* out))
      (dolist (file *required-ps-files*)
        (ps:ps-compile-file file))))
  output-file-name)
