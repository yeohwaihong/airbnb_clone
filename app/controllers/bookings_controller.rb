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
    byebug
    respond_to do |format|
      if @booking.save
        format.html { redirect_to @listing, notice: 'Booking was successfully created.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render 'bookings/form' }
        format.json { render json: @booking.errors, status: "bobs" }
      end
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
      format.html { redirect_to listings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def booking_params
    params.require(:booking).permit(:num_guests, :start_date, :end_date)
  end
end
