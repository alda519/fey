class AddCounterCacheToBricks < ActiveRecord::Migration
  def self.up
    add_column :users, :bricks_count, :integer, :default => 0
    def User.readonly_attributes; nil end # hack
    User.find(:all).each do |u|
      u.update_attribute :bricks_count, u.bricks.count
    end
  end

  def self.down
    remove_column :users, :bricks_count
  end
end
