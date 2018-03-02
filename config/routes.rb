Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  authenticated :user do
    root 'home#index', as: 'authenticated_root'
  end
  devise_scope :user do
    root 'devise/sessions#new'
  end
  
  scope controller: :subjects do
    get '/subjects', to:"subjects#new"
    post '/subjects', to:"subjects#create"
  end
  
  scope controller: :questions do
    get '/questions', to:"questions#new"
    post '/questions', to:"questions#create"
  end
  
  get 'photos', to:"home#index"
  

end
