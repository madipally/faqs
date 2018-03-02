class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def self.provides_callback_for(provider)
    class_eval %Q{
       def #{provider}
         auth = request.env["omniauth.auth"]
         if @user = User.find_by("email = ?",auth.info.email)
           sign_in_and_redirect @user
         else
           @user = User.from_omniauth(auth)
           sign_in_and_redirect @user
         end
        end
     }
  end
  
  [:facebook,:google_oauth2,:instagram].each do |provider|
    provides_callback_for provider
  end
  
end
