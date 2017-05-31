class User < ApplicationRecord
  include Clearance::User
  has_many :listings, :dependent => :destroy
  has_many :authentications, :dependent => :destroy
  enum role: [:user, :vip, :admin]

  after_initialize :set_default_role, :if => :new_record?

  mount_uploader :avatar, AvatarUploader



  def self.create_with_auth_and_hash(authentication, auth_hash)
      user = User.create!(name: auth_hash["extra"]["raw_info"]["name"], email: auth_hash["extra"]["raw_info"]["email"] || "noemail@fella.com")
      user.authentications << (authentication)
      return user
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

   def set_default_role
     self.role ||= :user
   end

end
