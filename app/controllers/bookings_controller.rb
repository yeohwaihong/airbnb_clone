class BookingsController < ApplicationController
  def index
    @booking = Booking.all
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.find(params[:id])
  end

  # GET /listings/1/edit
  def edit
  end

  def new
    @listing = Listing.find(params[:listing_id])
    @booking = Booking.new
    render "bookings/form"
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @booking = @listing.bookings.new(booking_params)
    @booking.user_id = current_user.id
    # 1) added the validation methods here
    if @booking.save
      @host = User.find(@listing.user_id)
          # ReservationMailer.notification_email(current_user.email, @host, @booking.listing.id, @booking.id).deliver_later
          ReservationJob.perform_later(current_user.email, @host, @booking.listing.id, @booking.id)
          redirect_to listing_booking_path(@listing, @booking) , notice: "Your booking has been created, please make payment to confirm the booking."
    else
      #2) make flash messages
      redirect_to listing_path(@listing), flash: {danger: "check your max num guests or overlapped dates"}

    end
  end

  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_path, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date, :listing_id, :user_id)
  end
end
