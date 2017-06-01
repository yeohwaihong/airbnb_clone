class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :listings, index: true, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :num_guests

      t.timestamps
    end
  end
end
