class Post < ActiveRecord::Base

  has_many   :comments
  belongs_to :location

  attr_accessible :title, :content, :author, :permalink, :location_id

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :permalink, :presence => true, :uniqueness => true, :format => /^[-\w\d]+$/, :length => { :maximum => 100 }

  def to_param
    self.permalink
  end

end
