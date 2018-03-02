class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:omniauthable,omniauth_providers: [:facebook,:google_oauth2,:instagram]
         
  #validates_presence_of :first_name,:last_name,:email,:encrypted_password
  
  #validates :email,uniqueness: true
         
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
       user.email = auth.info.email
       user.first_name = auth.info.first_name
       user.last_name = auth.info.last_name
       user.provider = auth.provider
       user.uid = auth.uid
       user.password = Devise.friendly_token[0,20]
    end
  end
  
  #instance method
  def name
   [first_name,last_name].join " "
  end
  #class method
  def self.by_letter(letter)
   where("last_name LIKE ?","#{letter}%").order(:last_name)
  end
end
