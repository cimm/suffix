class Page < ActiveRecord::Base

  attr_accessible :title, :content, :permalink, :in_navigation

  validates :title, :presence => true, :length => { :maximum => 100 }
  validates :permalink, :presence => true, :uniqueness => true, :format => /^[-+\w\d]+$/, :length => { :maximum => 100 }

  def to_param
    self.permalink
  end

  def self.last_update
    if last_page = order("updated_at desc").first
      last_page.updated_at
    end
  end

  def self.search(query)
    where("title LIKE ? or content LIKE ?", "%#{query}%", "%#{query}%")
  end

end
