Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'create_tour', to: 'tours#create_tour' 
  get '/tours/:id', to: 'tours#show'
end
