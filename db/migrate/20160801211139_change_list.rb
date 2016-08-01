class ChangeList < ActiveRecord::Migration
  def change
    change_column :lists, :source, :string, :default => nil
  end
end
