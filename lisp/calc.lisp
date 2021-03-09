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

(defun calc-waza-hirameki-list (waza-list
                                閃き済み技-list
                                enemy-waza-level
                                character-閃き可能-waza-list
                                include-固有技)
  (loop for waza in waza-list
     when (and (not (includes 閃き済み技-list waza))
               (includes character-閃き可能-waza-list waza))
     append
       (loop for (level from unique-weapon) in (find-閃き-alist waza nil)
          for prob = (calc-閃き確率 enemy-waza-level level)
          when (and (plusp prob)
                    (if include-固有技 t (not unique-weapon)))
          collect (list waza prob from level unique-weapon))))
