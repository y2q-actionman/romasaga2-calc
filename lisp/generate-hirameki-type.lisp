(in-package :romasaga2)

(defparameter *rs2techlearnflag-regex*
  "[0-9]{3}\\([0-9A-F]{2}\\): (.+?)\\s*:\\s+[○×]\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])\\s+([○×])")

(defun read-rs2techlearnflag-file (&optional (path "rs2techlearnflag.txt"))
  "Reads http://s-endo.skr.jp/rs2techlearnflag.txt"
  (let ((result (make-array 16 :initial-element nil :element-type 'list)))
    (with-open-file (stream path :external-format :sjis)
      (loop for line = (read-line stream nil :eof)
         until (eq line :eof)
         do (multiple-value-bind (match-start match-end reg-starts reg-ends)
                (cl-ppcre:scan *rs2techlearnflag-regex* line)
              (declare (ignore match-end))
              (when match-start
                (loop with tech-name = (subseq line (aref reg-starts 0) (aref reg-ends 0))
                   with tech-symbol = (intern tech-name)
                   for i from 1 to 16
                   as maru-batu = (char line (aref reg-starts i))
                   when (char= maru-batu #\○)
                   do (pushnew tech-symbol
                               (aref result (1- i))))))))
    result))

(defparameter *閃き可能-waza-list-array*
  (read-rs2techlearnflag-file))

(defun 閃き可能-waza-list)
