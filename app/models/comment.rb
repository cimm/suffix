class Comment < ActiveRecord::Base

  belongs_to :post

  attr_accessible :content, :author, :mail, :url

  validate :comments_are_open

  validates :content, :presence => true
  validates :url, :url_format => true

  private

  def comments_are_open
    unless post.comments_open?
      errors.add(:base, "Comments for this post are closed.")
    end
  end

end
