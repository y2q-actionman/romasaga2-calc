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

(defun print-result (enemy-waza-level character-name
                     &key (include-固有技 nil))
  (format t "~&敵 ~A, Level ~D~%"
          "TODO" enemy-waza-level)
  (let ((閃き-type (find-閃き-type-by-character-name character-name)))
    (format t "~2&名前 ~A 閃きタイプ ~A (~A)~%"
            character-name (閃き-type-id 閃き-type) (閃き-type-name 閃き-type))
    (flet ((print-waza-list (name 閃き-list character-閃き可能-waza-list 固有技-list)
             (loop initially (format t "~&~A~%" name)
                for (level waza from) in 閃き-list
                as normal = (find waza character-閃き可能-waza-list)
                as unique = (if include-固有技 (find waza 固有技-list))
                when (or normal unique)
                do (let ((prob (calc-閃き確率 enemy-waza-level level)))
                     (when (plusp prob)
                       (format t " ~@[Unique~] ~A ~F (from ~A) (level ~A) ~%"
                               waza prob from level unique))))))
      (print-waza-list "剣技" *剣技-閃き-list* (閃き-type-剣 閃き-type) *剣固有技-list*)
      (print-waza-list "大剣技" *大剣技-閃き-list* (閃き-type-大剣 閃き-type) *大剣固有技-list*)
      (print-waza-list "斧技" *斧技-閃き-list* (閃き-type-斧 閃き-type) *斧固有技-list*)

      )))


(defun test ()
  (print-result 11                      ; gelatious matter
                'ベア
                :include-固有技 t))
