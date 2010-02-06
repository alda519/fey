class CreateBricks < ActiveRecord::Migration
  def self.up
    create_table :bricks do |t|
      t.column :user_id, :integer
      t.column :title, :string
      t.column :text, :text
      t.timestamps
    end
  end

  def self.down
    drop_table :bricks
  end
end
