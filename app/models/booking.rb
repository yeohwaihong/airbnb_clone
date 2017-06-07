class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing
  # 3) remove validate:
  # validate :check_overlapping_dates #not using validation because my computer rmbrs what i just keyed in as listing.bookings
  # validate :check_max_guests

  def check_overlapping_dates

    listing.bookings.each do |old_booking|

      if overlap?(self, old_booking)
        #4) remove errors.add since its no longer a validate method
        return false
        #  if errors.add(:overlapping_dates, "The booking dates conflict with existing bookings.")
      end
    end
  end

  def overlap?(x,y)
    (x.start_date - y.end_date) * (y.start_date - x.end_date) > 0
  end

  def check_max_guests
    max_guests = listing.guest_number
#5) remove errors.add since its no longer a validate method
    return false if self.num_guests > max_guests
    # errors.add(:check_max_guests, "Max guests number exceeded.")
  end

  def total_price
    price = listing.price_per_night
    num_dates = (start_date..end_date).to_a.length
    return price * (num_dates - 1)
  end

  def check_negative_guests
    return if num_of_guests >= 1
    errors.add(:negative_guests, "There must be at least 1 guest.")
  end

  def check_past_dates
    return if start_date == DateTime.now.to_date.past?
  end

end
