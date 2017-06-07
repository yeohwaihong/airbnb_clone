class RemovePricingFromBookings < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :pricing, :integer
  end
end
