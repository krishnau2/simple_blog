class User < ActiveRecord::Base
  has_many :posts, :dependent => :destroy


  def is_admin?
    category == "admin"
  end

  def is_moderator?
    category == "moderator"
  end

end
