class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :title
      t.text :description
      t.integer :user_id
    end
  end
end
