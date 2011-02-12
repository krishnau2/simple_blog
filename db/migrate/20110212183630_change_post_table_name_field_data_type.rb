class ChangePostTableNameFieldDataType < ActiveRecord::Migration
  def self.up
    change_column :posts, :name_id, :integer
  end

  def self.down
    change_column :posts, :name_id, :string
  end
end
