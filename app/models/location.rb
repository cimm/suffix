class Location < ActiveRecord::Base

  has_many :posts

  attr_accessible :label, :latitude, :longitude, :current

  after_save :set_current_location

  validates :label, :presence => true, :uniqueness => { :case_sensitive => false }, :length => { :maximum => 50 }
  validates :latitude, :presence => true, :numericality => true
  validates :longitude, :presence => true, :numericality => true

  def self.current
    where("current = ?", true).first
  end

  private

  def set_current_location
    Location.update_all("current = 0", "id != #{id}") if current
  end

end
