class AddCommentsOpenToPost < ActiveRecord::Migration

  def self.up
    add_column :posts, :comments_open, :boolean, :default => 1
  end

  def self.down
    remove_column :posts, :comments_open
  end

end
