class AddPaymentMadeToBookings < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :payment_made, :boolean, default: false
  end
end
