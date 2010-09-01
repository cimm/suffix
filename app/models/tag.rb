class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :posts, :through => :taggings

  attr_accessible :name

  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 50 }

  def to_s
    name
  end

end
