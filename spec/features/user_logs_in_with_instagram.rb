require 'rails_helper'

RSpec.feature "user logs in" do
   scenario "using instagram" do
       stub_ominauth
       visit root_path
       expect(page).to have_link("Sign in with Instagram")
       click_link "Sign in with Instagram"
       expect(page).to have_content("Successfully logged in.")
       expect(page).to have_css("img[src*='https://scontent.cdninstagram.com/vp/212c1cb20df0ad56f25ec18aab2edec8/5B29057D/t51.2885-19/s150x150/28150915_175361483249243_8759529780933558272_n.jpg']")
       expect(page).to have_link("Logout")
   end
end

def stub_ominauth
  # first, set omniauth to run in test mode
  OmniAuth.config.test_mode = true
  
  #then, provide a set of fake oauth data that omniauth will use when user tries to authenticate
  OmniAuth.config.mock_auth[:instagram] = OmniAuth::AuthHash.new({
      provider: "instagram",
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

