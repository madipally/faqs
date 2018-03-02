module ControllerMacros
  def sign_in_as_valid_user_driver
       @user ||= FactoryGirl.create :user
       page.driver.post user_session_path, :user => {:email => @user.email, :password => @user.password}
  end
end