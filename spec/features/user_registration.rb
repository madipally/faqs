require 'rails_helper'

feature 'User registration' do
    scenario 'A user creates an account' do
        visit new_user_registration_path
        fill_in "user_first_name", with: 'abc'
        fill_in "user_last_name", with: 'adf'
        fill_in "user_email", with: 'bugs@gamil'
        fill_in "user_password", with: '12345678'
        fill_in "user_password_confirmation", with: '12345678'
        
        click_button 'Sign up'
        
        expect(page).to have_content('Edit profile')
        expect(page).to have_link('Logout')
    end
end
