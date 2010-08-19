class CreateLocations < ActiveRecord::Migration

  def self.up
    create_table :locations do |t|
      t.string  :label,     :null => false, :unique => true
      t.float   :latitude,  :null => false
      t.float   :longitude, :null => false
      t.boolean :current,   :null => false, :default => false
      t.timestamps
    end
    add_index :locations, :current
  end

  def self.down
    drop_table :locations
  end

end
