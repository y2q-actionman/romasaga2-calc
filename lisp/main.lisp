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
    (format t "剣技~%")
    (print-waza-list (append *剣技-list* *剣固有技-list*) ; TODO: concatinate them at defparameter?
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "大剣技~%")
    (print-waza-list (append *大剣技-list* *大剣固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "斧技~%")
    (print-waza-list (append *斧技-list* *斧固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "棍棒技~%")
    (print-waza-list (append *棍棒技-list* *棍棒固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "槍技~%")
    (print-waza-list (append *槍技-list* *槍固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "小剣技~%")
    (print-waza-list (append *小剣技-list* *小剣固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "弓技~%")
    (print-waza-list (append *弓技-list* *弓固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "体術技~%")
    (print-waza-list (append *体術技-list* *体術固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (format t "爪技~%")
    (print-waza-list (append *爪技-list* *爪固有技-list*)
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    ))

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
  (dolist (waza-list (list *剣技-list* *大剣技-list* *斧技-list* *棍棒技-list*
                           *槍技-list* *小剣技-list* *弓技-list* *体術技-list* *爪技-list*))
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
