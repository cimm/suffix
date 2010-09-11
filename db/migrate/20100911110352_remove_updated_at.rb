class RemoveUpdatedAt < ActiveRecord::Migration

  def self.up
    remove_column :comments, :updated_at
    remove_column :taggings, :updated_at
  end

  def self.down
    add_column :comments, :updated_at, :datetime
    add_column :taggings, :updated_at, :datetime
  end

end
