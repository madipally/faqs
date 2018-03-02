require 'rails_helper'

RSpec.describe User, type: :model do
    
    describe "Testing OmniAuth" do
        
        let!(:fb_auth) { OmniAuth::AuthHash.new({
           provider: "facebook",
           uid: "12345678910",
           info: {
              email: "madipallynaveen@gmail.com",
              first_name: "Madipally",
              last_name: "Kumar"
           },
           credentials: {
              token: "abdefer1212",
              expires_at: DateTime.now,
           }
        })}
        
        let!(:google_auth) { OmniAuth::AuthHash.new({
           provider: "google_auth",
           uid: "12345678910",
           info: {
              email: "madipallynaveen@gmail.com",
              first_name: "Madipally",
              last_name: "Naveen Kumar"
           },
           credentials: {
              token: "abdefer1212",
              expires_at: DateTime.now,
           }
        })}        
        
        context "with facebook" do
            it "creates or updates itself from an oauth hash of facebook" do
                
                User.from_omniauth(fb_auth)
               
                new_user = User.first
                
                expect(new_user.provider).to eq("facebook")
                expect(new_user.uid).to eq("12345678910")
                expect(new_user.email).to eq("madipallynaveen@gmail.com")
                expect(new_user.first_name).to eq("Madipally")
                expect(new_user.last_name).to eq("Kumar")
            end
        end
        
        context "with google" do
            it "creates or updates itself from an oauth hash of google" do
                
                User.from_omniauth(google_auth)
               
                new_user = User.first
                expect(new_user.provider).to eq("google_auth")
                expect(new_user.uid).to eq("12345678910")
                expect(new_user.email).to eq("madipallynaveen@gmail.com")
                expect(new_user.first_name).to eq("Madipally")
                expect(new_user.last_name).to eq("Naveen Kumar")
            end
        end        
    end
    
    describe "Normal user signup" do
    
        it { should validate_presence_of(:email) }
        it { should validate_presence_of(:first_name) }
        it { should validate_presence_of(:last_name) }
        it { should validate_presence_of(:encrypted_password) }    
        
       it "has a valid factory" do
         FactoryGirl.create(:user).should be_valid
       end
       it "is invalid without a first name" do
         FactoryGirl.build(:user, first_name: nil).should_not be_valid
       end
       it "is invalid without a last name" do
         FactoryGirl.build(:user,last_name: nil).should_not be_valid
       end
       it "is invalid without email" do
         FactoryGirl.build(:user, email:nil).should_not be_valid
       end
       it "is invalid without password" do
         FactoryGirl.build(:user, encrypted_password:nil).should_not be_valid
       end
       it "is invalid with duplicate email" do
          FactoryGirl.create(:user,email:"madipallynaveen123@gmail.com")
          FactoryGirl.build(:user,email:"madipallynaveen123@gmail.com").should_not be_valid
       end
    end
    
    describe "validating email" do
       it "email must be unique" do
         user = User.new(email:'bugs@gmail.com',password:'12345678',first_name:'abc',last_name:'dd')
         user.save
         u = User.new(email:'bugs@gmail.com',password:'12345678',first_name:'abc',last_name:'dd')
         u.save
         expect(u.errors.get(:email)).to eq(['has already been taken'])
       end
       
       it "email with invalid format is invalid" do
          user = User.new(email:'bugs',password:'123456',first_name:'ab',last_name:'dd')
          user.save
          
          expect(user.errors.get(:email)).to eq(['is invalid'])
       end
       
       it "has no errors for valid email" do
          user = User.new(email:'bugs@gmail.com',password:'12345678',first_name:'abc',last_name:'dd')
          user.save

          expect(user.errors.get(:email)).to be_empty
       end
       
    end
    
    describe "concating first_name, last_name" do
       it "returns a contact full name as a string" do
         user = FactoryGirl.build(:user,first_name: "Naveen",last_name: "Madipally")
         user.name.should == "Naveen Madipally"
       end
    end

    describe "filter last_name by letter" do
      
      before :each do
        @samhitha = FactoryGirl.create(:user,last_name: "Samhitha")
        @viru = FactoryGirl.create(:user,last_name: "Viru")
        @vinu = FactoryGirl.create(:user,last_name: "Vinu")
      end
      
      context "matching letters" do
        it "returns a sorted array of results that match" do
          User.by_letter("V").should == [@vinu,@viru]
        end
      end
      
      context "non-matching letters" do
         it "does not return users that don't start with the provided letter" do
           User.by_letter("V").should_not include @samhitha
        end
      end        
    end
end