(in-package :cl-user)

(defpackage :romasaga2-user
  (:use :cl :romasaga2 :romasaga2-name)
  (:export))

(in-package :romasaga2-user)

(defvar *user-閃き済み-剣技-list*
  '(なぎ払い)
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-大剣技-list*
  '(みね打ち)
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-斧技-list*
  '()
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-棍棒技-list*
  '(脳天割り)
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-槍技-list*
  '(二段突き)
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-小剣技-list*
  '(フェイント
    サイドワインダー)
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-弓技-list*
  '(イド・ブレイク)
  "これを適当にコメントアウトして使うこと")

(defvar *user-閃き済み-体術技-list*
  '(キック
    ふみつけ
    サラマンダークロー
    赤竜波)
  "これを適当にコメントアウトして使うこと")

(defvar *main-enemy*
  'ディープワン
  "敵名を指定する")

(defvar *main-member-list* '(ジェラール ベア ジェイムズ テレーズ アリエス))

(defun main (&key (enemy *main-enemy*)
               (member-list *main-member-list*))
  (print-all enemy member-list
             (append *user-閃き済み-剣技-list*
                     *user-閃き済み-大剣技-list*
                     *user-閃き済み-斧技-list*
                     *user-閃き済み-棍棒技-list*
                     *user-閃き済み-槍技-list*
                     *user-閃き済み-小剣技-list*
                     *user-閃き済み-弓技-list*
                     *user-閃き済み-体術技-list*)))
