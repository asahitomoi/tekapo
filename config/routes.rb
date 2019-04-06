Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root'homes#show'
  resources :homes,except: [:show]
  get"home/eat"=>"homes#eat"
  get"home/play"=>"homes#play"
  resources :pictures
end
