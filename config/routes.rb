# frozen_string_literal: true
Rails.application.routes.draw do
  resources :performers, except: [:new, :edit]
  resources :shows, except: [:new, :edit]
  resources :calendars, except: [:new, :edit]
  resources :location_geos, except: [:new, :edit]
  resources :venue_calendars, except: [:new, :edit]
  resources :venues, except: [:new, :edit]
  resources :venue_searches, except: [:new, :edit]
  resources :artist_states, except: [:new, :edit]
  resources :locations, except: [:new, :edit]
  resources :concerts, except: [:new, :edit]
  resources :upcoming_events, except: [:new, :edit]
  resources :similar_artists, except: [:new, :edit]
  resources :artists, except: [:new, :edit]
  # resources :artist_searches, except: [:new, :edit]
  resources :regions, except: [:new, :edit]
  resources :region_searches, except: [:new, :edit]
  # resources :events, except: [:new, :edit]
  resources :examples, except: [:new, :edit]
  get '/artist_searches/:id' => 'artist_searches#show', :constraints => { :id => /[^\/]+/ }
  post '/sign-up' => 'users#signup'
  post '/sign-in' => 'users#signin'
  delete '/sign-out/:id' => 'users#signout'
  patch '/change-password/:id' => 'users#changepw'
  resources :users, only: [:index, :show]
end
