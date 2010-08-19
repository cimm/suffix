class Comment < ActiveRecord::Base

  belongs_to :post

  attr_accessible :content, :author, :mail

  validates :content, :presence => true

end
