class HomeController < ApplicationController
  def index
    flash["notice"] = "Successfully logged in."
    basic_data = HTTParty.get("https://api.instagram.com/v1/users/self/?access_token=7199476616.0f926c2.a987f235668546848bddd6d69d755f36")
 
    @data = basic_data["data"]
    recent_data = HTTParty.get("https://api.instagram.com/v1/users/self/media/recent/?access_token=7199476616.0f926c2.a987f235668546848bddd6d69d755f36")
    @r_data = recent_data["data"] 
  end

end  