RSpec.describe  "SessionsController",type: :controller do
    login_user
    
    it "should have a current user" do
      expect(subject.current_user).to_not eq(nil)
    end
    
    it "should get index" do
      get 'index'
      response.should be_success
    end
end