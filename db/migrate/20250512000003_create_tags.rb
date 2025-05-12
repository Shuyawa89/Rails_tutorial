class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.text :description
      # 不要なカラム（冗長なデータベース設計）
      t.string :created_by
      t.string :color, default: "#3498db"

      t.timestamps
    end
    
    # インデックスがない（パフォーマンスの問題）
  end
end