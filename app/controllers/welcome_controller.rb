class WelcomeController < ApplicationController
  def home
    @listing = Listing.all
    get_pokemon_url
  end

  def get_pokemon_url
    response = RestClient.get("http://pokeapi.co/api/v2/pokemon/#{rand(1..251)}/")
    result = JSON.parse(response.body)

    @pokemon_url = result["sprites"]["front_default"]
    @pokemon_name = result["name"]
    @pokemon_no = result["id"]
    @pokemon_type = result["types"][0]["type"]["name"]
  end
end
