class Location < ActiveRecord::Base

  has_many :posts

  attr_accessible :label, :latitude, :longitude, :current

  validates :label, :presence => true, :uniqueness => { :case_sensitive => false }, :length => { :maximum => 50 }
  validates :latitude, :presence => true, :numericality => true
  validates :longitude, :presence => true, :numericality => true

  def self.current
    where("current = ?", true).first
  end

  # TODO Current check should be here in the model, not in the controller

end
