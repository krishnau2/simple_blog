class User < ActiveRecord::Base
  has_many :posts

  def get_user_name(user_id)
    user_details = User.find(user_id)
    return user_details.name
  end
end
