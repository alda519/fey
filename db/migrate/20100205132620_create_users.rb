class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login, :string
      t.column :name, :string
      t.column :email, :string
      t.column :web, :string
      t.column :group, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
