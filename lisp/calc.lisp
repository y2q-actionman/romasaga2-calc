(in-package :romasaga2)

(defun calc-閃き確率 (enemy-waza-level waza-level)
  ;; http://s-endo.skr.jp/gameprog_analysis.html#Description-RS2
  (let* ((level-diff (- enemy-waza-level waza-level))
         (境界値
          (cond ((<= level-diff -6) 0)
                ((>= level-diff 7) 30)
                (t (case level-diff
                     (-6 0)
                     (-5 1)
                     (-4 3)
                     (-3 5)
                     (-2 8)
                     (-1 11)
                     (0	50)
                     (1	18)
                     (2	21)
                     (3	24)
                     (4	26)
                     (5	28)
                     (6	29)
                     (7 30))))))
    (ecase 境界値
      (0	0)
      (1	1/255)
      (3	2/255)
      (5	4/255)
      (8	6/255)
      (11	13/255)
      (18	20/255)
      (21	22/255)
      (24	22/255)
      (26	24/255)
      (28	24/255)
      (29	25/255)
      (30	25/255)
      (50	52/255))))

(defun print-waza-list  (waza-list
                         閃き済み技-list
                         enemy-waza-level
                         character-閃き可能-waza-list
                         include-固有技)
  (dolist (waza waza-list)
    (when (and (not (find waza 閃き済み技-list))
               (find waza character-閃き可能-waza-list))
      (let ((hirameki-list (find-閃き-alist waza nil)))
        (loop for (level from unique-weapon) in hirameki-list
           for prob = (calc-閃き確率 enemy-waza-level level)
           when (and (plusp prob)
                     (if include-固有技 t (not unique-weapon)))
           do (format t " ~A	~5,3F	(from ~A)	(level ~A)	~@[~A~]~%"
                      waza prob from level unique-weapon))))))

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

(defun print-固有技 (enemy-waza-level
                     &key (additional-閃き済み技-list nil))
  (print-result enemy-waza-level 'レオン
                :additional-閃き済み技-list additional-閃き済み技-list
                :include-固有技 t))
