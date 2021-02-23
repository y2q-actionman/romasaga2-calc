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

(defun print-waza-list  (waza-type-name
                         閃き-list
                         閃き済み技-list
                         enemy-waza-level
                         character-閃き可能-waza-list
                         include-固有技)
  (loop initially (format t "~A~%" waza-type-name)
     for (level waza from unique-weapon) in 閃き-list
     for normal = (if unique-weapon nil (find waza character-閃き可能-waza-list))
     for unique = (and include-固有技 unique-weapon)
     when (and (or normal unique)
               (not (find waza 閃き済み技-list)))
     do (let ((prob (calc-閃き確率 enemy-waza-level level)))
          (when (plusp prob)
            (format t " ~A	~5,3F	(from ~A)	(level ~A)	~@[~A~]~%"
                    waza prob from level unique-weapon)))))

(defun print-固有技 (enemy-waza-level
                     &key (additional-閃き済み技-list nil))
  (let ((閃き済み技-list (append additional-閃き済み技-list *閃き済み技-list*))
        (閃き-type-id (find-閃き-type-id-by-character-name 'レオン)))
    (format t "~2&固有技 閃きタイプ ~A (~A)~%"
            閃き-type-id (find-閃き-type-name-by-閃き-type-id 閃き-type-id))
    (print-waza-list "剣技" *剣技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "大剣技" *大剣技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "斧技" *斧技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "棍棒技" *棍棒技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "槍技" *槍技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "小剣技" *小剣技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "弓技" *弓技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)
    (print-waza-list "体術技" *体術技-閃き-list*
                     閃き済み技-list enemy-waza-level nil t)))

(defun print-result (enemy-waza-level character-name
                     &key (include-固有技 nil)
                       (additional-閃き済み技-list nil))
  (let* ((閃き済み技-list (append additional-閃き済み技-list *閃き済み技-list*))
         (閃き-type-id (find-閃き-type-id-by-character-name character-name))
         (閃き可能-waza-list (find-閃き可能-waza-list-by-閃き-type-id 閃き-type-id)))
    (format t "~2&名前 ~A 閃きタイプ ~A (~A)~%"
            character-name 閃き-type-id (find-閃き-type-name-by-閃き-type-id 閃き-type-id))
    (print-waza-list "剣技" *剣技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "大剣技" *大剣技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "斧技" *斧技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "棍棒技" *棍棒技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "槍技" *槍技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "小剣技" *小剣技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "弓技" *弓技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)
    (print-waza-list "体術技" *体術技-閃き-list*
                     閃き済み技-list enemy-waza-level 閃き可能-waza-list include-固有技)))
