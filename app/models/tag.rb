class Tag < ApplicationRecord
  # バリデーションがない（データ整合性の問題）
  
  # def self.popular_tags
  #   Tag.all.sort_by { |tag| tag.name.length }.reverse
  # end
  
  def self.search(query)
    where("name LIKE '%#{query}%'")
  end
  
  def posts_count
    Micropost.all.select { |post| post.content.include?(self.name) }.size
  end
end