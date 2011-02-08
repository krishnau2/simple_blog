class Post < ActiveRecord::Base
  validates :name, :presence => true
  validates :topic, :presence => true

  has_many :comments
  has_attached_file :attachment
end
