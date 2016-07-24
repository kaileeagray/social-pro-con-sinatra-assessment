class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.string :source, :default => false
      t.text :description
      t.integer :user_id
      t.integer :pro_sum
      t.integer :con_sum
      t.timestamps null: false
    end
  end
end
