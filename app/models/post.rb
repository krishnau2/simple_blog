class Post < ActiveRecord::Base
  before_validation :clear_attachment
  validates :topic, :presence => true

  belongs_to :users
  has_many :comments
  has_attached_file :attachment

  def get_current_user_post(current_user_id)
    return Post.where("name_id = ? ", current_user_id)
  end

  def delete_attachment=(value)
    @delete_attachment = !value.to_i.zero?
  end

  def delete_attachment
    !!@delete_attachment
  end

  alias_method :delete_attachment?, :delete_attachment

  def clear_attachment
    self.attachment = nil if delete_attachment? && !attachment.dirty?
  end
end
