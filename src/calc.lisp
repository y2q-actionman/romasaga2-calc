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
  (format t "敵 ~A, Level ~D~%名前 ~A"
          "TODO" enemy-waza-level character-name)
  (let ((閃き-type (find-閃き-type-by-character-name character-name)))
    (format t "~2&剣技~%")
    (let ((閃き可能-waza-list (閃き-type-剣 閃き-type)))
      (loop for (waza level from) in *剣技-閃き-list*
         when (find waza 閃き可能-waza-list)
         do (let ((prob (calc-閃き確率 enemy-waza-level level)))
              (when (plusp prob)
                (format t " ~A ~A (from ~A)~%" waza level from)))))))


(defun test ()
  (print-result 11                      ; gelatious matter
                'ベア))
