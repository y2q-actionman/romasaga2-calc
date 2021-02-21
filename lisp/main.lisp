(in-package :romasaga2)

(defparameter *user-閃き済み-剣技-list*
  '(なぎ払い
    ;; パリイ
    ;; 二段斬り
    ;; 短冊斬り
    ;; みじん斬り
    ;; 線斬り
    ;; 空圧波
    ;; 十文字斬り
    ;; つむじ風
    ;; 音速剣
    ;; 光速剣
    ;; 真空斬り
    ;; 残像剣
    ;; 不動剣

    ;; 落月破斬
    ;; プロミネンス斬
    ;; 風狼剣
    ;; 咬竜剣
    ;; サクション
    ;; 分子分解
    ;; スウォーム
    ;; カマイタチ
    ;; 稲妻斬り
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-大剣技-list*
  '(みね打ち
    ;; 巻き打ち
    ;; 強撃
    ;; ディフレクト
    ;; 切り落とし
    ;; ツバメ返し
    ;; 水鳥剣
    ;; 無無剣
    ;; 無明剣
    ;; 流し斬り
    ;; 乱れ雪月花
    ;; 清流剣
    ;; 活人剣

    ;; 雷殺斬
    ;; 聖光
    ;; 月影
    ;; 一刀両断
    ;; 退魔神剣
    ;; 殺虫剣
    ;; 殺人剣
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-斧技-list*
  '(
    ;; アクスボンバー
    ;; トマホーク
    ;; 一人時間差
    ;; ヨーヨー
    ;; 大木断
    ;; ブレードロール
    ;; 次元断
    ;; 高速ナブラ
    ;; マキ割りスペシャル
    ;; スカイドライブ

    ;; フェザーシール
    ;; 電光ブーメラン
    ;; 死の舞い
    ;; 幻体戦士法
    ;; デストラクション
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-棍棒技-list*
  '(
    ;; 返し突き
    脳天割り
    ;; 骨砕き
    ;; 削岩撃
    ;; ダブルヒット
    ;; 地裂撃
    ;; グランドスラム
    ;; オゾンビート
    ;; フルフラット
    ;; かめごうら割り

    ;; ウェアバスター
    ;; 動くな
    ;; スペルエンハンス
    ;; 祝福
    ;; グランドバスター
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-槍技-list*
  '(
    ;; 足払い
    二段突き
    ;; 稲妻突き
    ;; くし刺し
    ;; チャージ
    ;; エイミング
    ;; 風車
    ;; 一文字突き
    ;; 活殺化石衝
    ;; スパイラルチャージ
    ;; 活殺獣神衝
    ;; 無双三段

    ;; ポセイドンシュート
    ;; サンダーボルト
    ;; 下り飛竜
    ;; サイコバインド
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-小剣技-list*
  '(フェイント
    ;; 感電衝
    サイドワインダー
    ;; マリオネット
    ;; スネークショット
    ;; マタドール
    ;; 乱れ突き
    ;; プラズマスラスト
    ;; スクリュードライバ
    ;; 幻惑剣
    ;; ファイナルレター

    ;; マッドバイター
    ;; ライフスティール
    ;; 火龍出水
    ;; 百花繚乱
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-弓技-list*
  '(
    ;; 瞬速の矢
    ;; でたらめ矢
    ;; 影ぬい
    ;; ビーストスレイヤー
    ;; アローレイン
    ;; 二本射ち
    イド・ブレイク
    ;; 影矢
    ;; バラージシュート
    ;; 落鳳破
    ;; イヅナ

    ;; ハートシーカー
    ;; 皆死ね矢
    ;; スターライトアロー
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *user-閃き済み-体術技-list*
  '(キック
    ;; ソバット
    ;; カウンター
    ;; ネコだまし
    ;; 集気法
    ;; 気弾
    ;; コークスクリュー
    ;; 不動金しばり
    ;; カポエラキック
    ;; マシンガンジャブ
    ;; ジョルトカウンター
    ;; クワドラブル
    ;; 活殺破邪法
    ;; 千手観音

    ふみつけ
    サラマンダークロー
    赤竜波

    ;; ベルセルク
    )
  "これを適当にコメントアウトして使うこと")

(defparameter *main-enemy*
  ;; 'ミミック
  ;; 'ゼラチナスマター
  ;; '魔道士
  'ディープワン
  ;; 'パイロレクス
  ;; 'タームソルジャー
  ;; 'サンドバイター
  ;; 'ラッフルツリー
  ;; '守護者
  ;; '水龍
  ;; '金龍
  ;; 'ミスティック
  ;; 'アルビオン
  )

(defparameter *main-member-list* '(ジェラール ベア ジェイムズ テレーズ アリエス))

(defun main (&key (include-固有技 nil)
               (enemy *main-enemy*)
               (member-list *main-member-list*)
               (enemy-waza-level (find-waza-level-by-enemy-name enemy)))
  (format t "~&敵 ~A Level ~D~2%" enemy enemy-waza-level)
  (let ((additional-閃き済み技-list
         (append *user-閃き済み-剣技-list*
                              *user-閃き済み-大剣技-list*
                              *user-閃き済み-斧技-list*
                              *user-閃き済み-棍棒技-list*
                              *user-閃き済み-槍技-list*
                              *user-閃き済み-小剣技-list*
                              *user-閃き済み-弓技-list*
                              *user-閃き済み-体術技-list*)))
    (loop for m in member-list
       do (print-result enemy-waza-level m
                        :include-固有技 include-固有技
                        :additional-閃き済み技-list additional-閃き済み技-list))
    (print-固有技 enemy-waza-level :additional-閃き済み技-list additional-閃き済み技-list)))


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
    ;; "hirameki-type.lisp"
    ;; "calc.lisp"
    ))

(defun make-romasaga2-js (&optional (output-file-name "romasaga2.js"))
  (with-open-file (out output-file-name :direction :output :if-exists :supersede)
    (let ((ps:*parenscript-stream* out))
      (dolist (file *required-ps-files*)
        (ps:ps-compile-file file))))
  output-file-name)
