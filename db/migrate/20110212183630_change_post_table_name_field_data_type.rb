class ChangePostTableNameFieldDataType < ActiveRecord::Migration
  def self.up
    change_column :posts, :name_id, :integer
    add_index :posts, :name_id
  end

  def self.down
    change_column :posts, :name_id, :string
    remove_index :posts, :name_id
  end
end
