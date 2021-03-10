;;; -*- coding: utf-8; -*-

(in-package :romasaga2)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (define-assoc-list +閃き-alist+
      find-閃き-alist
    (;; (剣攻撃)
     (なぎ払い . ((5 剣攻撃)))
     (パリイ . ((5 剣攻撃)))
     (二段斬り . ((8 剣攻撃)))
     (短冊斬り . ((19 剣攻撃) (15 なぎ払い)))
     (みじん斬り . ((15 剣攻撃) (12 線斬り)))
     (線斬り . ((27 剣攻撃) (23 二段斬り)))
     (空圧波 . ((18 剣攻撃)))
     (十文字斬り . ((14 なぎ払い)))
     (つむじ風 . ((20 なぎ払い)))
     (音速剣 . ((30 線斬り) (25 剣攻撃)))
     (光速剣 . ((49 剣攻撃) (35 音速剣)))
     (真空斬り . ((40 なぎ払い) (28 つむじ風)))
     (残像剣 . ((30 剣攻撃) (25 音速剣)))
     (不動剣 . ((45 剣攻撃)))
     ;;
     (落月破斬 . ((7 剣攻撃 三日月刀)))
     (プロミネンス斬 . ((20 剣攻撃 炎の剣)))
     (風狼剣 . ((10 剣攻撃 幻獣剣)))
     (咬竜剣 . ((31 剣攻撃 幻獣剣) (25 風狼剣 幻獣剣)))
     (サクション . ((16 剣攻撃 スペクターソード)))
     (分子分解 . ((17 剣攻撃 スプラッシャー)))
     (スウォーム . ((13 剣攻撃 ワームスレイヤー)))
     (カマイタチ . ((23 剣攻撃 風神剣)))
     (稲妻斬り . ((35 剣攻撃 風神剣)))
     ;; 
     ;; (大剣攻撃)
     (みね打ち . ((7 大剣攻撃)))
     (ディフレクト . ((5 大剣攻撃)))
     (巻き打ち . ((9 大剣攻撃)))
     (強撃 . ((12 大剣攻撃)))
     (切り落とし . ((20 大剣攻撃) (16 巻き打ち)))
     (流し斬り . ((24 大剣攻撃)))
     (無無剣 . ((25 大剣攻撃)))
     (水鳥剣 . ((26 大剣攻撃) (21 流し斬り)))
     (清流剣 . ((32 大剣攻撃) (25 流し斬り)))
     (ツバメ返し . ((40 大剣攻撃) (37 切り落とし) (34 強撃)))
     (乱れ雪月花 . ((41 大剣攻撃) (37 ツバメ返し)))
     (無明剣 . ((38 無無剣)))
     (活人剣 . ((44 大剣攻撃)))
     ;; (活人剣 . ((37 みね打ち)))
     ;;
     ;; (ダンシングソード)
     (雷殺斬 . ((16 大剣攻撃 名刀千鳥) (12 強撃 名刀千鳥)))
     (聖光 . ((14 大剣攻撃 デイブレード)))
     (月影 . ((17 大剣攻撃 ムーンライト)))
     (殺虫剣 . ((19 大剣攻撃 ヴォーパルソード)))
     (殺人剣 . ((29 大剣攻撃 ヴォーパルソード) (21 殺虫剣 ヴォーパルソード)))
     (退魔神剣 . ((22 大剣攻撃 妖刀龍光)))
     (一刀両断 . ((35 大剣攻撃 オートクレール) (25 強撃 オートクレール)))

     ;; (斧攻撃)
     (トマホーク . ((6 斧攻撃)))
     (アクスボンバー . ((11 斧攻撃)))
     (大木断 . ((15 斧攻撃)))
     (次元断 . ((24 斧攻撃) (15 大木断) (14 ブレードロール)))
     (一人時間差 . ((19 斧攻撃)))
     (ブレードロール . ((27 斧攻撃) (20 大木断)))
     (ヨーヨー . ((45 斧攻撃) (20 トマホーク)))
     (高速ナブラ . ((36 斧攻撃) (28 一人時間差)))
     (マキ割りスペシャル . ((40 斧攻撃) (36 一人時間差)))
     (スカイドライブ . ((46 斧攻撃) (38 トマホーク)))
     ;;
     (電光ブーメラン . ((25 斧攻撃 トアマリンの斧) (5 トマホーク トアマリンの斧)))
     (フェザーシール . ((10 斧攻撃 レディホーク)))
     (デストラクション . ((31 斧攻撃 デストロイヤー) (15 マキ割りスペシャル デストロイヤー)))
     (幻体戦士法 . ((28 斧攻撃 アメジストの斧)))
     (死の舞い . ((30 斧攻撃 ヴォーパルアクス)))

     ;; (棍棒攻撃)
     (脳天割り . ((9 棍棒攻撃)))
     (返し突き . ((5 棍棒攻撃)))
     (地裂撃 . ((15 棍棒攻撃)))
     (骨砕き . ((23 棍棒攻撃) (16 脳天割り)))
     (ダブルヒット . ((18 棍棒攻撃)))
     (削岩撃 . ((25 棍棒攻撃) (20 ダブルヒット)))
     (フルフラット . ((26 棍棒攻撃)))
     (グランドスラム . ((29 地裂撃)))
     (オゾンビート . ((34 棍棒攻撃)))
     (かめごうら割り . ((43 骨砕き) (39 ダブルヒット)))
     ;;
     (ウェアバスター . ((8 棍棒攻撃 シルバーハンマー)))
     (動くな . ((10 棍棒攻撃 タンブラーロッド)))
     (スペルエンハンス . ((12 棍棒攻撃 セージロッド)))
     (祝福 . ((13 棍棒攻撃 リバティスタッフ)))
     (グランドバスター . ((15 棍棒攻撃 コムルーンハンマ)))

     ;; 槍攻撃
     (二段突き . ((10 槍攻撃)))
     (足払い . ((6 槍攻撃)))
     (エイミング . ((8 槍攻撃)))
     (風車 . ((9 槍攻撃)))
     (くし刺し . ((15 槍攻撃)))
     (チャージ . ((18 槍攻撃)))
     (一文字突き . ((20 槍攻撃)))
     (活殺化石衝 . ((27 槍攻撃) (20 エイミング)))
     (稲妻突き . ((22 槍攻撃)))
     (活殺獣神衝 . ((51 槍攻撃) (36 エイミング)))
     (無双三段 . ((40 槍攻撃) (38 二段突き)))
     (スパイラルチャージ . ((48 槍攻撃) (39 チャージ)))
     ;;
     (ポセイドンシュート . ((17 槍攻撃 トライデント) (12 くし刺し トライデント)))
     (サンダーボルト . ((24 槍攻撃 青水晶の槍) (14 稲妻突き 青水晶の槍)))
     (サイコバインド . ((32 槍攻撃 神槍ロンギヌス)))
     (下り飛竜 . ((48 槍攻撃 竜槍ゲイボルグ) (45 チャージ 竜槍ゲイボルグ) (38 スパイラルチャージ 竜槍ゲイボルグ)))

     ;; 小剣攻撃
     (フェイント . ((7 小剣攻撃)))
     (サイドワインダー . ((14 小剣攻撃)))
     (感電衝 . ((8 小剣攻撃)))
     (マタドール . ((11 小剣攻撃)))
     (プラズマスラスト . ((19 小剣攻撃) (15 感電衝) (13 乱れ突き)))
     (スネークショット . ((27 小剣攻撃) (20 サイドワインダー)))
     (幻惑剣 . ((25 小剣攻撃)))
     (マリオネット . ((25 小剣攻撃)))
     (スクリュードライバ . ((38 小剣攻撃) (27 サイドワインダー)))
     (乱れ突き . ((30 小剣攻撃)))
     (ファイナルレター . ((40 小剣攻撃)))
     ;;
     (マッドバイター . ((15 小剣攻撃 ロブオーメン) (5 サイドワインダー ロブオーメン)))
     (百花繚乱 . ((23 小剣攻撃 イロリナの星) (17 乱れ突き イロリナの星)))
     (火龍出水 . ((36 小剣攻撃 赤水晶のロッド)))
     (ライフスティール . ((80 小剣攻撃 ソウルセイバー)))
     
     ;; 弓攻撃
     (イド・ブレイク . ((8 弓攻撃)))
     (でたらめ矢 . ((6 弓攻撃)))
     (影ぬい . ((10 弓攻撃)))
     (二本射ち . ((12 弓攻撃)))
     (ビーストスレイヤー . ((16 弓攻撃)))
     (アローレイン . ((26 弓攻撃) (16 でたらめ矢)))
     (影矢 . ((33 弓攻撃) (20 二本射ち)))
     (瞬速の矢 . ((21 弓攻撃)))
     (落鳳破 . ((22 弓攻撃) (22 ビーストスレイヤー)))
     (バラージシュート . ((40 弓攻撃) (25 でたらめ矢)))
     (イヅナ . ((46 弓攻撃) (36 瞬速の矢)))
     ;;
     (ハートシーカー . ((19 弓攻撃 ウインクキラー) (9 ビーストスレイヤー ウインクキラー)))
     (皆死ね矢 . ((13 弓攻撃 グリムリーパー)))
     (スターライトアロー . ((37 アローレイン 星天弓)))

     ;; パンチ
     (キック . ((9 パンチ)))
     (集気法 . ((3 パンチ)))
     (ネコだまし . ((5 パンチ)))
     (カウンター . ((8 パンチ)))
     (ソバット . ((12 キック)))
     (気弾 . ((13 パンチ)))
     (不動金しばり . ((24 パンチ) (13 気弾)))
     (ジョルトカウンター . ((19 カウンター)))
     (コークスクリュー . ((20 パンチ)))
     (カポエラキック . ((28 キック) (21 ソバット)))
     (マシンガンジャブ . ((26 パンチ)))
     (クワドラブル . ((30 ソバット)))
     (活殺破邪法 . ((45 パンチ) (35 気弾)))
     (千手観音 . ((43 マシンガンジャブ)))
     ;;
     (ベルセルク . ((15 集気法)))
     )
    "Waza -> list of (level from-waza &optional unique-weapon)")
  (import-and-export (collect-tree-symbol +閃き-alist+)
                     *romasaga2-name-package*))


;;; 技

(eval-when (:compile-toplevel :load-toplevel :execute)
  (define-constant +技種類-list+
      '(剣技 大剣技 斧技 棍棒技 槍技 小剣技 弓技 体術技 爪技)
    :test 'equal)
  (import-and-export +技種類-list+
                     *romasaga2-name-package*))


(eval-when (:compile-toplevel :load-toplevel :execute)
  (define-assoc-list +技種類-技一覧-alist+
      find-技種類-技一覧-alist
    ((剣技
      . (;; 剣攻撃
         なぎ払い パリイ 二段斬り 十文字斬り
         みじん斬り 短冊斬り 空圧波 つむじ風 線斬り
         音速剣 残像剣 真空斬り 光速剣 不動剣
         落月破斬 プロミネンス斬 風狼剣 咬竜剣 サクション
         分子分解 スウォーム カマイタチ 稲妻斬り
         ファイナルストライク))
     (大剣技
      . (;; 大剣攻撃
         みね打ち ディフレクト 巻き打ち 強撃
         切り落とし 流し斬り 無無剣 水鳥剣 清流剣
         ツバメ返し 乱れ雪月花 無明剣 活人剣

         ダンシングソード 雷殺斬 聖光 月影
         殺虫剣 殺人剣 退魔神剣 一刀両断)
      )
     (斧技
      . (;; 斧攻撃
         トマホーク アクスボンバー 大木断 次元断
         一人時間差 ブレードロール ヨーヨー 高速ナブラ
         マキ割りスペシャル スカイドライブ

         電光ブーメラン フェザーシール デストラクション 幻体戦士法 死の舞い))
     (棍棒技
      . (;; 棍棒攻撃
         脳天割り 返し突き 地裂撃 骨砕き
         ダブルヒット 削岩撃 フルフラット グランドスラム オゾンビート
         かめごうら割り

         ウェアバスター 動くな スペルエンハンス 祝福 グランドバスター
         シャッタースタッフ))
     (槍技
      . (;; 槍攻撃
         二段突き 足払い エイミング 風車
         くし刺し チャージ 一文字突き 活殺化石衝 稲妻突き
         活殺獣神衝 無双三段 スパイラルチャージ

         ポセイドンシュート サンダーボルト サイコバインド 下り飛竜))
     (小剣技
      . (;; 小剣攻撃
         フェイント サイドワインダー 感電衝 マタドール
         プラズマスラスト スネークショット 幻惑剣 マリオネット スクリュードライバ
         乱れ突き ファイナルレター

         マッドバイター 百花繚乱 火龍出水 ライフスティール))
     (弓技
      . (;; 弓攻撃
         イド・ブレイク でたらめ矢 影ぬい 二本射ち
         ビーストスレイヤー アローレイン 影矢 瞬速の矢 落鳳破
         バラージシュート イヅナ

         ハートシーカー 皆死ね矢 スターライトアロー))
     (体術技
      . (;; パンチ
         キック 集気法 ネコだまし カウンター
         ソバット 気弾 不動金しばり ジョルトカウンター コークスクリュー
         カポエラキック マシンガンジャブ クワドラブル 活殺破邪法 千手観音

         ふみつけ サラマンダークロー 赤竜波))
     (爪技
      . (;; 爪攻撃
         ベルセルク

         地獄爪殺法))
     ))
  (import-and-export (collect-tree-symbol +技種類-技一覧-alist+)
                     *romasaga2-name-package*))

;;;

(eval-when (:compile-toplevel :load-toplevel :execute)
  (define-constant +閃き済み技-list+
      '(剣攻撃 大剣攻撃 斧攻撃 棍棒攻撃 槍攻撃 小剣攻撃 弓攻撃 パンチ 爪攻撃
        なぎ払い みね打ち 脳天割り 二段突き フェイント サイドワインダー イド・ブレイク キック
        ダンシングソード ファイナルストライク シャッタースタッフ
        ふみつけ サラマンダークロー 赤竜波 地獄爪殺法)
    :test 'equal)
  (import-and-export +閃き済み技-list+
                     *romasaga2-name-package*))
