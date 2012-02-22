EpicTrip::Application.routes.draw do

  resources :events

  resources :calendars do
    resources :events
  end

end
