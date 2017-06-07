class BraintreeController < ApplicationController
  def new
    @client_token = Braintree::ClientToken.generate
    @booking = Booking.find(params[:booking_id])
  end

 def create
  @booking = Booking.find(params[:booking_id])
  nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
  amount_to_be_paid = @booking.total_price

 result = Braintree::Transaction.sale(
   :amount => amount_to_be_paid,
   :payment_method_nonce => nonce_from_the_client,
   :options => {
      :submit_for_settlement => true
    }
   )

   if result.success?
      @booking.payment_made = true
      @booking.save
      redirect_to :root, notice: "Transaction successful!"
    else
      redirect_to :root, notice: "Transaction failed. Please try again."
    end
  end
end
