class Post < ActiveRecord::Base
  before_validation :clear_attachment
  validates :topic, :presence => true

  belongs_to :user
  has_many :comments, :dependent => :destroy
  has_attached_file :attachment
  has_many :tags

  def related_tags
    self.tags.map {|tag| tag.name }.join(", ")
  end

  def can_be_edited_by?(user)
    not user.blank? and (user.id == user_id or user.is_moderator? or user.is_admin?)
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
