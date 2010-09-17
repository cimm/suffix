class RenamePostContentToMessage < ActiveRecord::Migration

  def self.up
    rename_column :posts, :content, :message
  end

  def self.down
    rename_column :posts, :message, :content
  end

end
