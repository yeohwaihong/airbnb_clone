class ReservationMailer < ApplicationMailer
  def booking_email(customer, host, reservation_id)
    @customer = current_user.find(params[:id])
    @host = Listing.find(params[:user_id])
    @reservation_id = Booking.find(params[:id])
  end
end
