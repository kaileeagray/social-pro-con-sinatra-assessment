class CreatePros < ActiveRecord::Migration
  def change
    create_table :pros do |t|
      t.integer :list_id
      t.integer :user_id
      t.integer :weight
      t.string :description
      t.timestamps null: false
    end
  end
end
