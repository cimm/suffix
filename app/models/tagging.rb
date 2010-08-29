class Tagging < ActiveRecord::Base

  belongs_to :tag
  belongs_to :post

  attr_accessible :post_id, :tag_id

  validates :tag_id, :presence => true, :uniqueness => {:scope => :post_id}

end
