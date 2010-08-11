class CreatePages < ActiveRecord::Migration

  def self.up
    create_table :pages do |t|
      t.string :title,     :null => false
      t.string :permalink, :null => false, :unique => true
      t.text   :content,   :null => false
      t.timestamps
    end
    add_index :posts, :permalink
  end

  def self.down
    drop_table :pages
  end

end
