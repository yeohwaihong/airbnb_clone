class GgThatStupidS < ActiveRecord::Migration[5.1]
  def change
    remove_reference :bookings, :listing, index: true, foreign_key: true
    add_reference :bookings, :listings, index: true, foreign_key: true
  end
end
