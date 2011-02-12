class Post < ActiveRecord::Base
  validates :name, :presence => true
  validates :topic, :presence => true

  belongs_to :users
  has_many :comments
  has_attached_file :attachment

  def get_current_user_post(current_user)
    return Post.where("name = ? ",current_user)
  end
end
