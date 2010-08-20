class CreateComments < ActiveRecord::Migration

  def self.up
    create_table :comments do |t|
      t.references :post,    :null => false
      t.text       :content, :null => false
      t.string     :author
      t.string     :mail
      t.timestamps
    end
    add_index :comments, :post_id
  end

  def self.down
    drop_table :comments
  end

end
