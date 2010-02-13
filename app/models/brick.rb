class Brick < ActiveRecord::Base

  validates_presence_of :title, :text

  belongs_to :user, :counter_cache => true

end
