class Post < ActiveRecord::Base
  validates :topic, :presence => true

  belongs_to :users
  has_many :comments
  has_attached_file :attachment

  def get_current_user_post(current_user_id)
    return Post.where("name_id = ? ",current_user_id)
  end
end
