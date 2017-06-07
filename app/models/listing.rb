class Listing < ApplicationRecord
  belongs_to :user
  has_many :bookings
  mount_uploaders :images, ImageUploader
  # serialize :column_name, JSON
  searchkick match: :word_start, searchable: [:country]
end
