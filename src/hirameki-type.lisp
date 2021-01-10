;;; -*- coding: utf-8; -*-

(in-package :romasaga2)

(defparameter *閃き済み技-list*
  '(剣攻撃 大剣攻撃 斧攻撃 棍棒攻撃 槍攻撃 小剣攻撃 弓攻撃 パンチ 爪攻撃
    なぎ払い みね打ち 脳天割り 二段突き フェイント サイドワインダー イド・ブレイク キック
    ダンシングソード ファイナルストライク シャッタースタッフ
    ふみつけ サラマンダークロー 赤竜波 地獄爪殺法))

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

(defparameter *閃き-type-alist*
  (list
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
    :弓 *弓-基本技-list*
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

(defparameter *character-name-to-閃き-type*
  '(
    ;; 帝国重装歩兵
    (ベア .	13)
    (バイソン .	13)
    (ウォーラス .	13)
    (スネイル .	14)
    (ヘッジホッグ .	13)
    (トータス .	13)
    (ライノ .	13)
    (フェルディナント .	13)
    ;; 帝国軽装歩兵（男）
    (ジェイムズ .	11)
    (ジョン .	11)
    (リチャード .	10)
    (ハーバート .	14)
    (ハリー .	11)
    (ロナルド .	13)
    (ドワイト .	11)
    (フランクリン .	14)
    ;; 帝国軽装歩兵（女）
    (ライーザ .	3)
    (ジェシカ .	14)
    (シャーリー .	3)
    (オードリー .	14)
    (ジュディ .	10)
    (グレース .	14)
    (イングリット .	3)
    (グレタ .	2)
    ;; 帝国猟兵（男）
    (ヘンリー .	2)
    (ルイ .	2)
    (チャールズ .	2)
    (ウィリアム .	2)
    (フィリップ .	2)
    (エドワード .	2)
    (アレクサンドル .	2)
    (フリードリッヒ .	2)
    ;; 帝国猟兵（女）
    (テレーズ .	2)
    (メアリー .	3)
    (アグネス .	2)
    (キャサリン .	2)
    (アン .	2)
    (ユリアナ .	2)
    (イザベラ .	2)
    (エリザベス .	2)
    ;; 宮廷魔術師（男）
    (アリエス .	5)
    (サジタリウス .	2)
    (ライブラ .	15)
    (タウラス .	15)
    (ジェミニ .	15)
    (カプリコーン .	5)
    (キグナス .	15)
    (クラックス .	15)
    ;; 宮廷魔術師（女）
    (エメラルド .	15)
    (アメジスト .	15)
    (オニキス .	15)
    (トパーズ .	15)
    (ガーネット .	15)
    (オパール .	15)
    (ルビー .	15)
    (サファイア .	3)
    ;; フリーファイター（男）
    (ヘクター .	11)
    (オライオン .	10)
    (ジェイスン .	9)
    (シーシアス .	9)
    (アキリーズ .	8)
    (ユリシーズ .	9)
    (パーシアス .	13)
    (ハーキュリーズ .	11)
    ;; フリーファイター（女）
    (アンドロマケー .	14)
    (シーデー .	2)
    (メディア .	14)
    (ヒッポリュテー .	9)
    (デーイダメイア .	11)
    (ペネロープ .	14)
    (アンドロメダ .	2)
    (ディアネイラ .	11)
    ;; フリーメイジ（男）
    (レグルス .	1)
    (アルゴル .	5)
    (ポラリス .	15)
    (カノープス .	5)
    (プロキオン .	5)
    (リゲル .	2)
    (ヴェガ .	15)
    (シリウス .	5)
    ;; フリーメイジ（女）
    (ローズ .	15)
    (リリィ .	3)
    (デイジー .	15)
    (アイリス .	15)
    (マグノリア .	0)
    (ヘイゼル .	15)
    (アイヴィ .	3)
    (ウィンドシード .	15)
    ;; インペリアルガード（男）
    (ワレンシュタイン .	9)
    (タンクレッド .	4)
    (ダブー .	4)
    (マールバラ .	4)
    (ハンニバル .	9)
    (エパミノンダス .	4)
    (グスタフ .	4)
    (ベリサリウス .	9)
    ;; インペリアルガード（女）
    (ミネルバ .	14)
    (ルナ .	9)
    (ユノー .	13)
    (セレス .	11)
    (オーロラ .	9)
    (フューリー .	9)
    (ヴィクトリア .	4)
    (ディアナ .	10)
    ;; 軍師
    (シゲン .	15)
    (ハクヤク .	15)
    (タンプク .	15)
    (チュウタツ .	15)
    (コウキン .	15)
    (ハクゲン .	8)
    (モウトク .	2)
    (コウメイ .	15)
    ;; イーストガード
    (ジュウベイ .	8)
    (テッシュウ .	8)
    (シュウサク .	8)
    (ガンリュウ .	8)
    (トシ .	8)
    (レンヤ .	10)
    (ボクデン .	8)
    (ソウジ .	8)
    ;; デザートガード
    (シャールカーン .	10)
    (ネマーン .	13)
    (ダンダーン .	13)
    (シャハリヤール .	14)
    (アバールハサン .	13)
    (マルザワーン .	13)
    (アルマノス .	13)
    (スライマーン .	10)
    ;; アマゾネス
    (ジャンヌ .	9)
    (クリームヒルト .	9)
    (エカテリーナ .	9)
    (テオドラ .	4)
    (アグリッピナ .	9)
    (アルテミシア .	2)
    (ブコウ .	9)
    (トモエ .	9)
    ;; ハンター
    (ハムバ .	2)
    (クワワ .	2)
    (ムジュグ .	2)
    (バイ .	2)
    (オセイ .	2)
    (ランガリ .	2)
    (ケチェワ .	2)
    (ガダフム .	2)
    ;; ノーマッド（男）
    (アルタン .	9)
    (ガルタン .	6)
    (バツー .	6)
    (エセン .	10)
    (ダヤン .	6)
    (アクダ .	6)
    (アボキ .	9)
    (ボクトツ .	6)
    ;; ノーマッド（女）
    (ファティマ .	2)
    (ベスマ .	2)
    (アリア .	2)
    (ミズラ .	2)
    (アズィーザ .	5)
    (ドニヤ .	14)
    (ノーズハトゥ .	2)
    (シャハラザード .	2)
    ;; ホーリーオーダー（男）
    (ゲオルグ .	9)
    (ピーター .	13)
    (ポール .	9)
    (ジェイコブ .	9)
    (ベネディクト .	10)
    (バランタイン .	13)
    (ウルバン .	9)
    (クリストフ .	14)
    ;; ホーリーオーダー（女）
    (ソフィア .	5)
    (アガタ .	15)
    (モニカ .	15)
    (ガートルード .	15)
    (バルバラ .	5)
    (マチルダ .	5)
    (マグダレーナ .	15)
    (マリア　 .	5)
    ;; 海女
    (ナタリー .	15)
    (マライア .	15)
    (ジャニス .	15)
    (オリヴィア .	5)
    (ケイト .	15)
    (サラ .	15)
    (デビー .	15)
    (リンダ .	15)
    ;; 武装商船団
    (エンリケ .	6)
    (マゼラン .	9)
    (ガマ .	2)
    (マハン .	9)
    (フィッシャー .	6)
    (ティルピッツ .	9)
    (テイワ .	6)
    (ドレイク .	10)
    ;; サイゴ族
    (エイリーク .	5)
    (ハールファグル .	5)
    (パールナ .	0)
    (アリンビョルン .	5)
    (エギル .	1)
    (オーラーヴ .	5)
    (シグルズ　 .	5)
    (スノリ .	1)
    ;; 格闘家
    (カール .	0)
    (フリッツ .	0)
    (ダイナマイト .	0)
    (テリー .	0)
    (ブルーザー .	0)
    (ベイダー .	0)
    (ハセ .	0)
    (ライガー .	1)
    ;; シティシーフ（男）
    (スパロー .	2)
    (クロウ .	3)
    (ロビン .	14)
    (ピジョン .	14)
    (スターリング .	10)
    (スイフト .	3)
    (スラッシュ .	10)
    (ファルコン .	2)
    ;; シティシーフ（女）
    (キャット .	0)
    (ビーバー .	3)
    (バジャー .	2)
    (マウス .	3)
    (ラビット .	10)
    (フェレット .	10)
    (ウィーゼル .	3)
    (フォックス .	3)
    ;; サラマンダー
    (ケルート .	6)
    (タンボラ .	5)
    (ガルンガン .	0)
    (アウ .	0)
    (メラピ .	5)
    (アグン .	6)
    (ソプタン .	11)
    (パパンダヤン .	0)
    ;; モール
    (シエロ .	3)
    (レゴ .	3)
    (チェルノ .	3)
    (ポド .	3)
    (ラト .	3)
    (グライ .	3)
    (バーティ .	3)
    (ブルニ .	3)
    ;; ネレイド
    (テティス .	15)
    (ペルーサ .	5)
    (リューシアナッサ .	15)
    (メリテー .	15)
    (アムピトリーテ .	15)
    (ナウシトエ .	15)
    (サオー .	5)
    (ガラテイア .	15)
    ;; イーリス
    (ウィンディ　 .	2)
    (クラウディア .	2)
    (スカイア　 .	2)
    (ブレズィア .	2)
    (ゲイル　 .	2)
    (エア .	2)
    (ストーミー .	2)
    (ナディール .	2)
    ;; 固有キャラ
    (レオン . 7)
    (ジェラール . 15)
    (コッペリア . 7)
    (最終皇帝男 . 14)
    (最終皇帝女 . 14)))
