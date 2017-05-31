class Avatar < ActiveRecord::Base
  attr_accessible :user, :email, :image
  mount_uploader :image, ImageUploader
end
