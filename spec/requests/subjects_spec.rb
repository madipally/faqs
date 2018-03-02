require 'rails_helper'
  describe "Subject" do
    before do
      sign_in_as_valid_user_driver
    end
    
    it 'allows users to create subject' do  
        visit "/subjects/new/"
    end
end