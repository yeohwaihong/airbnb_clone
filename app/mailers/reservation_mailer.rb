class ReservationMailer < ApplicationMailer

  default from: 'hausyourday@gmail.com'

  def notification_email(customer, host, listing_id, booking_id)
    @host = host
    @customer = customer
    @listing = Listing.find(listing_id)
    #once customer reserved a listing, it will send email to the listing host.
    mail(to: @host, subject: "You have received a booking from #{@customer}")

  end
end