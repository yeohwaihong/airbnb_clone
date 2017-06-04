class WelcomeController < ApplicationController
  def home
    @listing = Listing.all
  end
end
