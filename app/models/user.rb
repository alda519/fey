class User < ActiveRecord::Base

  validates_presence_of :login, :name, :password
  validates_uniqueness_of :login

  belongs_to :group

  has_many :bricks

  before_create :hash_password
  before_update :hash_password , :if => :password_changed?
  
  private
  def hash_password
    self.password = Digest::SHA1.hexdigest password
  end

end
