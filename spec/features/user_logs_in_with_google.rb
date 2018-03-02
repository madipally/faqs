require 'rails_helper'

RSpec.feature 'user logs in using google outh2' do
    scenario 'user logs in' do
      stub_ominauth
      visit root_path
      expect(page).to have_link('Sign in with GoogleOuath2')
      click_link 'Sign in with GoogleOuath2'
      expect(page).to have_content('Edit Profile')
      expect(page).to have_link('Logout')
    end
end

def stub_ominauth
  OmniAuth.config.test_mode = true
  
   #then, provide a set of fake oauth data that omniauth will use when user tries to authenticate
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: "12345678910",
      info: {
          email: "madipallynaveen@gmail.com",
          name: "Madipally Naveen Kumar"
      },
      credentials: {
          token: "abdefer1212",
          expires_at: DateTime.now,
      }
  })
end

