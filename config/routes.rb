Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'employees#index'
  resources :employees, except: %i[new create index destroy]
  resources :timesheets, except: [:destroy]
end
