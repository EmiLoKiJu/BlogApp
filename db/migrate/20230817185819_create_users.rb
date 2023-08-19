# Remplazed frozen_string_literal true for something else

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :photo
      t.text :bio
      t.timestamps
      t.integer :posts_counter
    end
  end
end
