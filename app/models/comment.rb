class Comment < ActiveRecord::Base

  belongs_to :post

  attr_accessible :content, :author, :mail, :url

  validates :content, :presence => true
  validates :url, :url_format => true

end
