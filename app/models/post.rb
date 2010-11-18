class Post < ActiveRecord::Base

  has_many   :comments, :dependent => :destroy
  has_many   :taggings, :dependent => :destroy
  has_many   :tags, :through => :taggings
  belongs_to :location

  attr_accessible :title, :message, :author, :permalink, :location_id, :comments_open

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :permalink, :presence => true, :uniqueness => true, :format => /^[-+\w\d]+$/, :length => { :maximum => 100 }

  def to_param
    self.permalink
  end

  def self.last_update
    if last_post = order("updated_at desc").first
      last_post.updated_at
    end
  end

  def self.search(query)
    where("title LIKE ? or message LIKE ?", "%#{query}%", "%#{query}%")
  end

end
