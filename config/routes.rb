Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'create_tour', to: 'tours#create_tour' 
  get '/tours/:id', to: 'tours#show'
  get '/tours/:tour_id/attractions', to: 'attraction_tours#show'
  post '/tours/:tour_id/attraction', to: 'attraction_tours#create'
  delete '/tours/:tour_id/attraction/:id', to: 'attraction_tours#destroy'
end
