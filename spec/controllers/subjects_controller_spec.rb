require 'rails_helper'

RSpec.describe SubjectsController, type: :controller do
    
    let(:valid_attributes) do
       attributes_for(:subject)
    end

    describe 'POST #create' do
      before do
        sign_in_as_valid_user_driver
      end
      context 'with valid attributes' do
        it 'creates the subject' do
          post :create, subject: attributes_for(:subject)
          expect(Subject.count).to eq(1)
        end
        
        it 'redirects to the show action for the new subject' do
          post :create, subject: attributes_for(:subject)
          expect(response).to redirect_to Subject.first
        end
      end
      
      context 'with invalid attributes' do
        it 'does not create the subject' do
          post :create, subject: attributes_for(:subject, name: nil)
          expect(Subject.count).to eq(0)
        end
        
        it 're-renders the new view' do
          post :create, subject: attributes_for(:subject, name: nil)
          expect(response).to render_template :new
        end
      end
      
      context 'json' do
        context 'with valid attributes' do
          it 'creates the subject' do
            post :create, subject: attributes_for(:subject), format: :json
            expect(Subject.count).to eq(1)
          end
          
          it 'responds with 201' do
            post :create, subject: attributes_for(:subject), format: :json
            expect(response).to have_http_status(201)
          end
        end
        
        context 'with invalid attributes' do
          it 'does not create subject' do
            post :create, subject: attributes_for(:subject, name: nil), format: :json
            expect(Subject.count).to eq(0)
          end
          
          it 'responds with 422' do
            post :create, subject: attributes_for(:subject,name: nil), format: :json
            expect(response).to have_http_status(422)
          end
        end
      end
    end
end
