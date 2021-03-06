Poc::Application.routes.draw do

  get "events/index"
  get "events/show"
  get "events/creat"
  get "events/new"
  root "pages#index"


  get "page/getusers"   => "pages#getUsers"
  get "messages"        => "messages#index", as: 'message'
  get "messages/reload" => "messages#indexer"
  get "messages/reload/:id" => "messages#indexerid"
  get "messages/send/:message_id/:message" => "messages#sender"
  post "messages/create" => "messages#create"
  get "messages/react_web/:receiver_id/:body/:message_id" => "messages#react_web"

  get "settings" => "users#settings", as: 'settings'
  get "settings/location" => "users#location",   as: 'user_location'
  get "settings/current_location" => "users#current_location"
  post "settings/save_location" => "users#save_location"

  get "aanbiedingen" => "users#offers"
  get "aanbiedingen/reload" => "users#get_offers"

  get "settings/adres"  => "users#adres",as: "settings_adres"

  get "chats/index"
  get "chats/chat/:id"    => "chats#show"
  post "chats/new"        => "chats#new",  as: "new_chat"

  get "profiel"                 => "users#profile", as: 'profile'
  get "gebruiker/profiel/:id"   => "users#profile", as: 'user_profile'
  post "users/create"           => "users#create"
  get "handleiding"             => "users#handleiding", as: 'handleiding'

  get '/auth/:provider/callback' => 'authentications#create', as: 'authentication'

  get "/registreer/adres"    => "users#address",   as: "user_address"


  resources :users
  resources :sessions, only: [:new, :create, :destroy]

  get "loguit"  => "sessions#destroy",        as: "logout"
  get "registreer"      => "users#new",       as: "register"
  get "dashboard"   => "dashboard#index",     as: "dashboard"

  get  "events"   =>  "events#index",         as: "events_all"
  post  "events"      =>  "events#create",    as: "event_create"
  post  "offers"      =>  "offers#create",    as: "offer_create"
  get  "events/show/:id"   =>  "events#show", as: "event"
  get  "events/delete/:id"   =>  "events#delete_event", as: "delete_event"
  get  "offers"   =>  "offers#index",         as: "offers_all"
  get  "offers/new"   =>  "offers#new",       as: "offer_new"
  get  "offers/show/:id"   =>  "offers#show", as: "offer"
  get  "offers/delete/:id"   =>  "offers#delete_offer", as: "delete"



  post "reactions/create"    =>  "reactions#create",  as: "reaction_create"


end
