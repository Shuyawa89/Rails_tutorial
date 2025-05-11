class Tag < ApplicationRecord
  # バリデーションがない（データ整合性の問題）
  
  # 使われていないメソッド（冗長なコード）
  def self.popular_tags
    Tag.all.sort_by { |tag| tag.name.length }.reverse
  end
  
  # SQLインジェクションの危険性（セキュリティの問題）
  def self.search(query)
    where("name LIKE '%#{query}%'")
  end
  
  # 非効率なメソッド（パフォーマンスの問題）
  def posts_count
    Micropost.all.select { |post| post.content.include?(self.name) }.size
  end
end