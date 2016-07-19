class CreateCons < ActiveRecord::Migration
  def change
    create_table :cons do |t|
      t.integer :list_id
      t.integer :user_id
      t.float :rank
      t.string :description
      t.timestamps null: false
    end
  end
end
