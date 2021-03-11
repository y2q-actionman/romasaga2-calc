;;; -*- coding: utf-8; -*-
(in-package :romasaga2)

(defparameter *回避技-list*
  '(パリイ ディフレクト 風車 マタドール 集気法 カウンター))

(defparameter *剣-基本技-list*	'(十文字斬り 空圧波 つむじ風 音速剣))
(defparameter *大剣-基本技-list*	'(水鳥剣 無無剣))
(defparameter *斧-基本技-list*	'(トマホーク アクスボンバー))
(defparameter *棍棒-基本技-list*	'(地裂撃 骨砕き ダブルヒット))
(defparameter *槍-基本技-list*	'(足払い エイミング チャージ 一文字突き))
(defparameter *小剣-基本技-list*	'(スネークショット 乱れ突き))
(defparameter *弓-基本技-list*	'(でたらめ矢 アローレイン 瞬速の矢))
(defparameter *体術-基本技-list*	'(気弾 ソバット))

(defstruct 閃き-type
  (id nil :type integer)
  (name nil :type symbol)
  (剣 *剣-基本技-list* :type list)
  (大剣 *大剣-基本技-list* :type list)
  (斧 *斧-基本技-list* :type list)
  (棍棒 *棍棒-基本技-list* :type list)
  (槍 *槍-基本技-list* :type list)
  (小剣 *小剣-基本技-list* :type list)
  (弓 *弓-基本技-list* :type list)
  (体術 *体術-基本技-list* :type list))

(defparameter *閃き-type-array*
  (vector
   (make-閃き-type
    :id 0 :name '体術A型
    :剣 *剣-基本技-list*
    :大剣 *大剣-基本技-list*
    :斧 (list* '大木断 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 *棍棒-基本技-list*
    :槍 *槍-基本技-list*
    :小剣 *小剣-基本技-list*
    :弓 *弓-基本技-list*
    :体術 (list* 'ベルセルク
                 (set-difference *体術技-list* '(ネコだまし 活殺破邪法))))
   (make-閃き-type
    :id 1 :name '体術B型
    :剣 *剣-基本技-list*
    :大剣 (list* '強撃 '清流剣 'ツバメ返し *大剣-基本技-list*)
    :斧 (list* '大木断 'ブレードロール 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 *棍棒-基本技-list*
    :槍 (list* '活殺化石衝 '活殺獣神衝 *槍-基本技-list*)
    :小剣 *小剣-基本技-list*
    :弓 (list* '落鳳破 *弓-基本技-list*)
    :体術 (list* 'ベルセルク
                 (remove 'クワドラブル *体術技-list*)))
   (make-閃き-type
    :id 2 :name '弓型
    :剣 (list* '真空斬り *剣-基本技-list*)
    :大剣 *大剣-基本技-list*
    :斧 *斧-基本技-list*
    :棍棒 *棍棒-基本技-list*
    :槍 *槍-基本技-list*
    :小剣 (list* '幻惑剣 *小剣-基本技-list*)
    :弓 *弓技-list*
    :体術 (list* 'コークスクリュー *体術-基本技-list*))
   (make-閃き-type
    :id 3 :name '小剣型
    :剣 (list* '真空斬り '光速剣 *剣-基本技-list*)
    :大剣 *大剣-基本技-list*
    :斧 *斧-基本技-list*
    :棍棒 (list* '返し突き *棍棒-基本技-list*)
    :槍 (list* 'くし刺し 'スパイラルチャージ *槍-基本技-list*)
    :小剣 *小剣技-list*
    :弓 (list* '二本射ち 'ビーストスレイヤー 'イヅナ *弓-基本技-list*)
    :体術 (list* 'ジョルトカウンター 'マシンガンジャブ *体術-基本技-list*))
   (make-閃き-type
    :id 4 :name '槍型
    :剣 *剣-基本技-list*
    :大剣 (list* '強撃 *大剣-基本技-list*)
    :斧 (list* '大木断 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 (list* '返し突き *棍棒-基本技-list*)
    :槍 *槍技-list*
    :小剣 (list* 'スクリュードライバ *小剣-基本技-list*)
    :弓 *弓-基本技-list*
    :体術 (list* 'コークスクリュー '活殺破邪法 *体術-基本技-list*))
   (make-閃き-type
    :id 5 :name '棍棒型
    :剣 (list* 'みじん斬り *剣-基本技-list*)
    :大剣 (list* '強撃 *大剣-基本技-list*)
    :斧 (list* '大木断 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 *棍棒技-list*
    :槍 *槍-基本技-list*
    :小剣 *小剣-基本技-list*
    :弓 *弓-基本技-list*
    :体術 (list* 'ネコだまし 'コークスクリュー *体術-基本技-list*))
   (make-閃き-type
    :id 6 :name '斧型
    :剣 (list* 'みじん斬り *剣-基本技-list*)
    :大剣 (list* '強撃 '切り落とし *大剣-基本技-list*)
    :斧 *斧技-list*
    :棍棒 (set-difference *棍棒技-list*
                          '(返し突き フルフラット オゾンビート))
    :槍 *槍-基本技-list*
    :小剣 *小剣-基本技-list*
    :弓 (list* '影ぬい '二本射ち *弓-基本技-list*)
    :体術 (list* 'コークスクリュー *体術-基本技-list*))
   (make-閃き-type
    :id 7 :name '皆無型
    :剣 ()
    :大剣 ()
    :斧 ()
    :棍棒 ()
    :槍 ()
    :小剣 ()
    :弓 ()
    :体術 ())
   (make-閃き-type
    :id 8 :name '大剣A型
    :剣 (set-difference *剣技-list* '(みじん斬り 残像剣 光速剣))
    :大剣 (remove '強撃 *大剣技-list*)
    :斧 (list* '大木断 '高速ナブラ 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 (list* '返し突き *棍棒-基本技-list*)
    :槍 (list* '稲妻突き '無双三段 *槍-基本技-list*)
    :小剣 (list* '感電衝 '幻惑剣 *小剣-基本技-list*)
    :弓 (list* '影ぬい '二本射ち '影矢 '落鳳破 *弓-基本技-list*)
    :体術 (list* 'ネコだまし '不動金縛り '活殺破邪法 *体術-基本技-list*))
   (make-閃き-type
    :id 9 :name '斧槍型
    :剣 (list* 'みじん斬り '真空斬り *剣-基本技-list*)
    :大剣 (list* '強撃 '切り落とし '乱れ雪月花 *大剣-基本技-list*)
    :斧 *斧技-list*
    :棍棒 (set-difference *棍棒技-list*
                          '(返し突き 削岩撃 フルフラット))
    :槍 *槍技-list*
    :小剣 (list* '感電衝 'プラズマスラスト 'マリオネット *小剣-基本技-list*)
    :弓 (list* '影ぬい *弓-基本技-list*)
    :体術 (list* 'コークスクリュー '活殺破邪法 *体術-基本技-list*))
   (make-閃き-type
    :id 10 :name '剣豪型
    :剣 (remove '光速剣 *剣技-list*)
    :大剣 (set-difference *大剣技-list*
                          '(ツバメ返し 活人剣))
    :斧 (list* '大木断 '一人時間差 '高速ナブラ 'マキ割りスペシャル
               *斧-基本技-list*)
    :棍棒 (list* '返し突き *棍棒-基本技-list*)
    :槍 (list* '活殺獣神衝 *槍-基本技-list*)
    :小剣 (remove 'マリオネット *小剣技-list*)
    :弓 (list* '二本射ち *弓-基本技-list*)
    :体術 (list* 'コークスクリュー *体術-基本技-list*))
   (make-閃き-type
    :id 11 :name '大剣B型
    :剣 (list* '二段斬り 'みじん斬り '真空斬り *剣-基本技-list*)
    :大剣 (set-difference *大剣技-list*
                          '(ツバメ返し 無明剣 活人剣))
    :斧 (list* '大木断 'ブレードロール 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 (list* '返し突き *棍棒-基本技-list*)
    :槍 *槍-基本技-list*
    :小剣 (list* 'スクリュードライバ *小剣-基本技-list*)
    :弓 (list* '影ぬい '二本射ち *弓-基本技-list*)
    :体術 (list* 'コークスクリュー *体術-基本技-list*))
   (make-閃き-type
    :id 12 :name '未使用                ; 術士型と同じ
    :剣 *剣-基本技-list*
    :大剣 (list* '強撃 *大剣-基本技-list*)
    :斧 (list* '大木断 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 *棍棒-基本技-list*
    :槍 *槍-基本技-list*
    :小剣 *小剣-基本技-list*
    :弓 (list* '影ぬい *弓-基本技-list*)
    :体術 *体術-基本技-list*)
   (make-閃き-type
    :id 13 :name '半端型
    :剣 (list* 'みじん斬り '真空斬り '不動剣 *剣-基本技-list*)
    :大剣 (list* '強撃 '乱れ雪月花 *大剣-基本技-list*)
    :斧 (list* '大木断 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 (list* '削岩撃 'オゾンビート *棍棒-基本技-list*)
    :槍 (list* 'くし刺し '活殺獣神衝 'スパイラルチャージ *槍-基本技-list*)
    :小剣 (list* 'スクリュードライバ *小剣-基本技-list*)
    :弓 (list* '影ぬい *弓-基本技-list*)
    :体術 (list* 'コークスクリュー *体術-基本技-list*))
   (make-閃き-type
    :id 14 :name '剣型
    :剣 (set-difference *剣技-list* '(みじん斬り 真空斬り))
    :大剣 (list* '切り落とし '流し斬り '清流剣
                 *大剣-基本技-list*)
    :斧 *斧-基本技-list*
    :棍棒 (list* '返し突き *棍棒-基本技-list*)
    :槍 (list* '稲妻突き '活殺化石衝 *槍-基本技-list*)
    :小剣 (list* '感電衝 'プラズマスラスト *小剣-基本技-list*)
    :弓 (list* '影ぬい '二本射ち *弓-基本技-list*)
    :体術 (list* 'マシンガンジャブ *体術-基本技-list*))
   (make-閃き-type
    :id 15 :name '術士型
    :剣 *剣-基本技-list*
    :大剣 (list* '強撃 *大剣-基本技-list*)
    :斧 (list* '大木断 'マキ割りスペシャル *斧-基本技-list*)
    :棍棒 *棍棒-基本技-list*
    :槍 *槍-基本技-list*
    :小剣 *小剣-基本技-list*
    :弓 (list* '影ぬい *弓-基本技-list*)
    :体術 *体術-基本技-list*)))

(defun find-閃き-type-by-character-name (name)
  (let ((閃き-type-id (find-閃き-type-id-by-character-name name)))
    (aref *閃き-type-array* 閃き-type-id)))
