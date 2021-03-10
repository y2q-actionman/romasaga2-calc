(in-package :romasaga2)


(defun print-waza-hirameki-result (waza-hirameki-result)
  "For `print-result'."
  (loop for (waza prob from level unique-weapon) in waza-hirameki-result
     do (format t " ~A	~5,3F	(from ~A)	(level ~A)	~@[~A~]~%"
                waza prob from level unique-weapon)))

(defun print-result (enemy-waza-level character-name
                     &key (include-固有技 nil)
                       (additional-閃き済み技-list nil))
  "For `print-all'."
  (let* ((閃き済み技-list (append additional-閃き済み技-list +閃き済み技-list+))
         (閃き-type-id (find-閃き-type-id-by-character-name character-name))
         (閃き可能-waza-list (find-閃き可能-waza-list-by-閃き-type-id 閃き-type-id)))
    (format t "~2&名前 ~A 閃きタイプ ~A (~A)~%"
            character-name 閃き-type-id (find-閃き-type-name-by-閃き-type-id 閃き-type-id))
    (format t "~& 初期技一覧: ~{~A~^ ~}~%"
            (find-character-初期技-list character-name 閃き済み技-list))
    (loop for waza-type in +技種類-list+
       as waza-list = (find-技種類-技一覧-alist waza-type)
       do (format t "~A~%" waza-type)
         (print-waza-hirameki-result
          (calc-waza-hirameki-list waza-list 閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)))))

(defun print-all (enemy member-list additional-閃き済み技-list
                  &key (enemy-waza-level (find-waza-level-by-enemy-name enemy)))
  "For romasaga2-user main function."
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
  "For making the frontend HTML parts."
  (format stream "<datalist id=\"all_waza_name\">~%")
  (dolist (waza-list (mapcar #'cdr +技種類-技一覧-alist+))
    (loop for waza in (rest waza-list)
       do (format stream "<option>~A<option> " waza))
    (terpri stream))
  (format stream "~&</datalist>"))

(defun print-all-waza-name-for-html-dojo (&optional (stream *standard-output*))
  "For making the frontend HTML parts."
  (format stream "<fieldset open>~%")
  (format stream "<legend>技道場登録状況</legend>~%")
  (loop for (type-name . waza-list) in +技種類-技一覧-alist+
     do (format stream "<details>~%")
       (format stream "<summary>~A</summary>~%" type-name)
       (loop initially (format stream "<ul>~%")
          for waza in waza-list
          do (format stream "<li><label><input type=\"checkbox\" ~:[~;checked disabled~] name=\"~A\"/>~:*~A</label></li>~%"
                     (member waza +閃き済み技-list+) waza)
          finally (format stream "</ul>~%"))
       (format stream "</details>~%"))
  (format stream "~&</fieldset>"))


;;; JS output

(defparameter *required-ps-files*
  '("waza-list.lisp"
    "monster-level.lisp"
    "hirameki-type.lisp"
    "initial-waza.lisp"
    "calc.lisp"
    ))

(defun make-romasaga2-js (&key (output-file-name "romasaga2.js")
                            ((:print-pretty ps:*ps-print-pretty*) ps:*ps-print-pretty*))
  (with-open-file (out output-file-name :direction :output :if-exists :supersede)
    (let ((ps:*parenscript-stream* out))
      (dolist (file *required-ps-files*)
        (ps:ps-compile-file file))))
  output-file-name)
