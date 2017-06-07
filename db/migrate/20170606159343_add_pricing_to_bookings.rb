class AddPricingToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :pricing, :integer
  end
end
