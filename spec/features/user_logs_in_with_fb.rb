require 'rails_helper'

RSpec.feature "user logs in" do
   scenario "using facebook" do
       stub_ominauth
       visit root_path
       expect(page).to have_link("Sign in with Facebook")
       click_link "Sign in with Facebook"
       expect(page).to have_content("Edit profile")
       expect(page).to have_link("Logout")
   end
end

def stub_ominauth
  # first, set omniauth to run in test mode
  OmniAuth.config.test_mode = true
  
  #then, provide a set of fake oauth data that omniauth will use when user tries to authenticate
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      provider: "facebook",
      uid: "12345678910",
      info: {
          email: "madipallynaveen@gmail.com",
          first_name: "Naveen Kumar",
          last_name: "Madipally"
      },
      credentials: {
          token: "abdefer1212",
          expires_at: DateTime.now,
      }
  })
end

