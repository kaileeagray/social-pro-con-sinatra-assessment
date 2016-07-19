class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.float :pro_sum
      t.float :con_sum
      t.timestamps null: false
    end
  end
end
