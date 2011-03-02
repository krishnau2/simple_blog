class ChangePostTableNameIdField < ActiveRecord::Migration
  def self.up
    rename_column :posts, :name_id, :user_id
  end

  def self.down
    rename_column :posts, :user_id, :name_id
  end
end
