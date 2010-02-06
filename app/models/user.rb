class User < ActiveRecord::Base

  validates_presence_of :login, :password, :name, :email
  validates_uniqueness_of :login

  belongs_to :group

  before_create :hash_password
  
  private
  def hash_password
    self.password = Digest::SHA1.hexdigest password
  end

end