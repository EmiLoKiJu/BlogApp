# Remplazed frozen_string_literal true for something else

class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.string :title
      t.text :text
      t.timestamps
      t.integer :comments_counter
      t.integer :likes_counter
    end
  end
end
