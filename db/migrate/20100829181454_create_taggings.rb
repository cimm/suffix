class CreateTaggings < ActiveRecord::Migration

  def self.up
    create_table :tags do |t|
      t.string :name, :null => false
    end
    create_table :taggings do |t|
      t.references :tag, :null => false
      t.references :post, :null => false
      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :post_id
    add_index :taggings, [:tag_id, :post_id], :unique => true
  end

  def self.down
    drop_table :taggings
    drop_table :tags
  end

end
