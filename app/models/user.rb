class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy

  def get_user_name(user_id)
    user_name = User.find(user_id).name
    return user_name
  end
end
