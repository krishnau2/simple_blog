class ChangePostTableNameField < ActiveRecord::Migration
  def self.up
    rename_column :posts, :name, :name_id
  end

  def self.down
    rename_column :posts, :name, :name_id
  end
end
