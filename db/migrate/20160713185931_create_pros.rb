class CreatePros < ActiveRecord::Migration
  def change
    create_table :pros do |t|
      t.integer :list_id
      t.integer :user_id
      t.integer :rank
      t.string :description
    end
  end
end
