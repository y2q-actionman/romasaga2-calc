(in-package :romasaga2)


(defun print-waza-hirameki-result (waza-hirameki-result)
  "For `print-result'."
  (loop for (waza prob from level unique-weapon status) in waza-hirameki-result
     do (format t " ~13A	~5,3F (Lv ~2D)	from ~A (~A)	~@[~A~]~%"
                waza prob level from status unique-weapon)))

(defun print-result (enemy-waza-level character-name character-装備技-alist
                     &key (include-固有技 nil)
                       (dojo-閃き済み技-list nil))
  "For `print-all'."
  (let* ((閃き-type-id (find-閃き-type-id-by-character-name character-name))
         (閃き可能-waza-list (find-閃き可能-waza-list-by-閃き-type-id 閃き-type-id))
         (装備技-list (if-let ((entry (assoc character-name character-装備技-alist)))
                        (cdr entry)
                        (find-character-初期技-list character-name dojo-閃き済み技-list))))
    (format t "~2&名前 ~A 閃きタイプ ~A (~A)~%"
            character-name 閃き-type-id (find-閃き-type-name-by-閃き-type-id 閃き-type-id))
    (format t "~& 装備技一覧: ~{~A~^ ~}~%" 装備技-list)
    (loop for waza-type in +技種類-list+
       as waza-list = (find-技種類-技一覧-alist waza-type)
       do (format t "~A~%" waza-type)
         (print-waza-hirameki-result
          (calc-waza-hirameki-list waza-list 装備技-list dojo-閃き済み技-list
                                   enemy-waza-level 閃き可能-waza-list include-固有技)))))

(defun print-all (enemy member-list dojo-閃き済み技-list
                  &key (enemy-waza-level (find-waza-level-by-enemy-name enemy))
                    (character-装備技-alist nil))
  "For romasaga2-user main function."
  (format t "~&敵 ~A Level ~D~2%" enemy enemy-waza-level)
  (loop for m in member-list
     do (print-result enemy-waza-level m character-装備技-alist
                      :include-固有技 nil
                      :dojo-閃き済み技-list dojo-閃き済み技-list))
  ;; 固有技
  (print-result enemy-waza-level 'レオン character-装備技-alist
                :dojo-閃き済み技-list dojo-閃き済み技-list
                :include-固有技 t))

;;; HTML output

(defun print-character-name-list-for-html-datalist (&optional (stream *standard-output*))
  "For making the frontend HTML parts."
  (format stream "<datalist id=\"characterNameList\">~%")
  (loop for name in (mapcar #'car +character-name-to-閃き-type-id+)
     for i from 0
     when (zerop (mod i 8))
     do (fresh-line stream)
     do (format stream "<option>~A</option> " name))
  (format stream "~&</datalist>"))

(defun print-all-waza-name-for-html-datalist (&optional (stream *standard-output*))
  "For making the frontend HTML parts."
  (format stream "<datalist id=\"allWazaNameList\">~%")
  (dolist (waza-list (mapcar #'cdr +技種類-技一覧-alist+))
    (loop for waza in waza-list
       do (format stream "<option>~A</option> " waza))
    (terpri stream))
  (format stream "~&</datalist>"))

(defun print-enemy-name-list-for-html-datalist (&optional (stream *standard-output*))
  "For making the frontend HTML parts."
  (format stream "<datalist id=\"enemyNameList\">~%")
  (loop for name in (mapcar #'car +enemy-name-to-waza-level-alist+)
     for i from 0
     when (zerop (mod i 16))
     do (fresh-line stream)
     do (format stream "<option>~A</option> " name))
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
                     (or (member waza +基本技-list+) (member waza +閃き済み技-list+))
                     waza)
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
