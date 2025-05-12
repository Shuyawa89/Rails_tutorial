---
marp: true
theme: default
paginate: true
backgroundColor: #fff
---

<!-- _class: lead -->
# GitHub Saved Repliesのすゝめ
#### LT - 2025年5月12日

---

## 自己紹介

<div class="columns">
<div>

- 名前：岩本修弥
- 所属：オフショア開発
- 会話デッキ:
  - 医療画像処理
  - 画像認識
  - ガジェット・電化製品
    - 部屋中を縦横無尽に動くデスク
  - カメラ
    - 風景写真
    - 深夜の崖をロープ一本で登らされた話

</div>
<div>

<!-- ここに自分の画像を配置 -->
![width:400px](profile.png)

</div>
</div>

<style>
.columns {
  display: flex;
  justify-content: space-between;
}
.columns > div {
  width: %;
}
</style>

---

# ところで

---

## みんなPRのレビューしてる？

- 🙋‍♂️ レビューをする側になったことがある人？
- 🙋‍♀️ レビューを受ける側になったことがある人？
- 🤔 レビューコメントの意図がわからなくて困ったことは？

---

## PRレビューの課題

- レビューコメントの**温度感がわからない**
  - 「修正が必須」なのか「単なる提案」なのか
  - 「質問」なのか「修正依頼」なのか
  
- コードレビューが**心理的負担**に
  - 「この指摘どこまで対応したらいいの？」
  - 「ほんとにこれ修正する必要ある？」
  - **「すべて修正が必要？」**
  - **「時間的にも全部対応したらかなりかかるな...」**

---

## 一般的なレビュー (Before)

```ruby
# app/controllers/tags_controller.rb
def tag_params
  params.require(:tag).permit(:name, :description, :created_by, :updated_at)
end

# コメント
created_at や updated_at は不要なパラメータなので制限して欲しいです！
```

```ruby
# app/models/tag.rb
def self.search(query)
  where("name LIKE '%#{query}%'")
end

# コメント
この書き方ではSQLインジェクション起きる可能性ありませんか？
```

---

## レビューの問題点

- 温度感がわからず、**すべて同じ重要度**に見える
- **修正が必須**なのか単なる提案なのか区別できない
- **質問なのか指摘なのか**曖昧
- レビュイーは**どれから対応すべきか判断できない**
- 納期に間に合わない場合の**優先順位付けが難しい**

---

## GitHub Saved Repliesとは

- GitHubの標準機能の一つ
- **よく使うレビューコメントを保存しておける**
- ボタン一つで呼び出せる

![bg right:30% width:90%](https://docs.github.com/assets/cb-34831/mw-1440/images/help/settings/saved-replies-settings.webp)

---

## バッジの種類と使い方

- ![badge-must](https://img.shields.io/badge/review-MUST-red) **MUST**：修正しないとApproveできない
- ![badge-imho](https://img.shields.io/badge/review-IMHO-yellow) **IMHO**：個人的な見解や軽微な提案（In My Humble Opinion）
- ![badge-nits](https://img.shields.io/badge/review-NITS-white) **NITS**：重箱の隅をつつく提案（Nitpicks）
- ![badge-fyi](https://img.shields.io/badge/review-FYI-white) **FYI**：参考情報（For Your Information）
- ![badge-question](https://img.shields.io/badge/review-Question-blue) **Question**：純粋な質問
- ![badge-good](https://img.shields.io/badge/review-good-%23019733) **Good**：良いコードへの称賛

---

## Saved Repliesを使ったレビュー (After)

```ruby
# app/controllers/tags_controller.rb
def tag_params
  params.require(:tag).permit(:name, :description, :created_by, :updated_at)
end
```

**コメント**
![badge-must](https://img.shields.io/badge/review-MUST-red) （修正しないとApproveできない）
created_at や updated_at は不要なパラメータなので制限してください。セキュリティ上の理由から、必要なパラメータのみ許可するべきです。

---

```ruby
# app/models/tag.rb
def self.search(query)
  where("name LIKE '%#{query}%'")
end
```

**コメント**
![badge-must](https://img.shields.io/badge/review-MUST-red) （修正しないとApproveできない）
 SQLインジェクションの脆弱性があります。以下のようにプレースホルダを使って修正してください：
`where("name LIKE ?", "%#{query}%")`


---

## Saved Repliesを使うメリット

- **意図が明確に伝わる**
  - 修正必須なのか、単なる提案なのかが一目瞭然
  - 質問と指摘が明確に区別できる

- **心理的安全性の向上**
  - レビュイーは優先順位を判断できる
  - 納期に間に合わない場合も対応の判断がしやすい
  - 「全部対応しなきゃ」というプレッシャーが減少

- **コミュニケーションの効率化**
  - 余計なやり取りが減少
  - レビュアーの意図を確認する手間が省ける

---

## 例：NITSの使い方

```ruby
# app/views/tags/index.html.erb
<% @tags.each do |tag| %>
<tr style="background-color: <%= tag.color %>20;">
    <td><%= link_to tag.name, tag_path(tag) %></td>
    <td><%= tag.description %></td>
    <td>
        <% if current_user && current_user.admin? %>
            <%= link_to "Edit", edit_tag_path(tag), class: "btn btn-sm btn-warning" %>
        <% end %>
    </td>
</tr>
<% end %>
```

![badge-nits](https://img.shields.io/badge/review-NITS-white) インデントが一部不揃いです。Rubyコミュニティでは通常2スペースを使用します。表示に影響はありませんが、一貫性のために修正すると良いでしょう。

---

## 例：FYIの使い方

```ruby
# app/controllers/tags_controller.rb
def destroy
  Tag.find(params[:id]).destroy
  flash[:success] = "Tag deleted"
  redirect_to tags_url
end
```

![badge-fyi](https://img.shields.io/badge/review-FYI-white) 参考までに、findで対象が見つからない場合は例外が発生します。もし404ページを表示したい場合は、以下のようにfind_byとpresence確認を使うパターンもあります：

```ruby
def destroy
  tag = Tag.find_by(id: params[:id])
  if tag.present?
    tag.destroy
    flash[:success] = "Tag deleted"
  end
  redirect_to tags_url
end
```

---

## 例：NRの使い方

```ruby
# app/controllers/tags_controller.rb
def show
  @tag = Tag.find(params[:id])
  @posts = Micropost.where("content LIKE ?", "%#{@tag.name}%")
           .paginate(page: params[:page], per_page: 10)
end
```

![badge-nr](https://img.shields.io/badge/review-NR-white) 現状の実装でも問題ありませんが、将来的にはタグと投稿の間に関連テーブルを作成することを検討してください。文字列検索ベースの実装はデータ量が増えると効率が悪くなる可能性があります。今後のリファクタリングの参考にしてください。

---

<!-- _class: lead -->
## まとめ

- Saved Repliesでレビューの温度感を伝えよう
- チーム内で共通のバッジを決めると効果的
- 特に新メンバーや初心者には非常に親切
- **心理的安全性の向上につながる**
- 数分で設定できるので、今日から使ってみましょう！

---

<!-- 以下は補足スライド -->

## 補足: 自分のsaved replyiesデッキ
```
![badge-fyi](https://img.shields.io/badge/review-FYI-white)　（参考までに共有，アクションは不要）
![badge-imho](https://img.shields.io/badge/review-IMHO-yellow)　（個人的な見解や軽微な提案，意見が割れそうなので確認を推奨）
![badge-good](https://img.shields.io/badge/review-good-%23019733)　（個人的に良いと思ったポイント）
![badge-IMO](https://img.shields.io/badge/review-IMO-orange)　（個人的な見解や軽微な提案，採用するか否かは自由）
![badge-must](https://img.shields.io/badge/review-MUST-red)　（これを直さないと承認できない）
![badge-nits](https://img.shields.io/badge/review-NITS-white)　（重箱の隅をつつく提案，無視しても良い）
![badge-nr](https://img.shields.io/badge/review-NR-white)　（今やらなくて良いが，将来的には解決したい提案）
![badge-question](https://img.shields.io/badge/review-Question-blue)　（質問，回答が必要）
```
↑これを一行ずつコピペして登録したら大丈夫

---

## 補足：バッジの作成方法

- [shields.io](https://shields.io/) を使用して作成
- Markdown形式で簡単に埋め込み可能
- カスタマイズ可能なパラメータ：
  - ラベル名 (`review`)
  - メッセージ (`MUST`, `NITS` など)
  - カラー (`red`, `yellow` など)

```
![badge-must](https://img.shields.io/badge/review-MUST-red)
```

![width:300px](https://img.shields.io/badge/review-MUST-red)

---

## 補足：Saved Repliesの使い方 (1/3)

### 方法1: キーボードショートカット

コメントフォームにフォーカスした状態で **Ctrl + .** （ピリオド）を押す

![bg right:40% width:100%](https://docs.github.com/assets/cb-151940/mw-1440/images/help/writing/saved-replies-menu.webp)

ショートカットキーで素早くアクセス

---

## 補足：Saved Repliesの使い方 (2/3)

### 方法2: UIボタンから選択

コメントフォームの右上にある返信アイコンをクリック

![bg right:40% width:100%](https://docs.github.com/assets/cb-25898/mw-1440/images/help/writing/saved-replies-button.webp)

アイコンが見つけやすいので初心者にも簡単

---

## 補足：Saved Repliesの使い方 (3/3)

### 方法3: スラッシュコマンド

コメントフォーム内で **/** （スラッシュ）を入力してコマンドメニューを表示

![bg right:40% width:100%](https://docs.github.com/assets/cb-60517/mw-1440/images/help/writing/command-palette-saved-replies.webp)

タイピングを続けると候補が絞り込まれる

---

## 補足：例：Questionの使い方

```ruby
# タグが見つからない場合の処理がない
def show
  # ...コード省略
  @tag = found_tag
end
```
 **コメント**
![badge-question](https://img.shields.io/badge/review-Question-blue) タグが見つからない場合の処理がありません。これは意図した挙動でしょうか？エラー処理を追加する予定はありますか？


---

## 補足：例：IMHOの使い方

```ruby
# app/controllers/tags_controller.rb
class TagsController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:edit, :update, :destroy]
  # ...
end
```

![badge-imho](https://img.shields.io/badge/review-IMHO-yellow) タグ操作に管理者権限が必要となっていますが、一般的には、タグの作成は一般ユーザーにも許可することが多いと思います。ユーザー体験の観点から検討してみてはいかがでしょうか？

---

## 補足：チーム内でのメリット

- **レビュアー側**
  - コメントの意図が明確に伝わる
  - 同じ指摘を何度も書く手間が省ける

- **レビュイー側**
  - 修正の優先度がわかる
  - 心理的負担が減る
  - 納期に間に合わない場合の優先順位決定が容易に

- **チーム全体**
  - レビュー基準の共通認識ができる
  - **心理的安全性が向上する**
