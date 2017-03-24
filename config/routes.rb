Rails.application.routes.draw do

  # mount ForestLiana::Engine => '/forest'
  ActiveAdmin.routes(self)

  # ROOT TO LANDING WEBSITE
  if Rails.env.development?
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  else
    root to: redirect("http://cforgood.com")
  end

  get 'notre_charte',             to: 'pages#charte'
  get 'cgu',                      to: 'pages#cgu'
  get 'faq_connect',              to: 'pages#faq_connect'
  put 'newsletter',               to: 'pages#newsletter'

  resources :contact_forms, only: [:new, :create]

  # ROOT TO APP CFORGOOD
  resources :businesses, only: [:index, :show]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', passwords: :passwords }, path: '', path_names: {:sign_in => 'signin', :sign_up => 'signup'}
  devise_scope :user do
    get 'signin',                   to: 'devise/sessions#new'
    post 'signin',                  to: 'devise/sessions#create'
    get 'signup',                   to: 'devise/registrations#new'
    post 'signup',                  to: 'devise/registrations#create'
    get 'signup_trial',             to: 'devise/registrations#new_gift'
    post 'signup_trial',            to: 'devise/registrations#create_gift'
    get 'signup_gift',              to: 'devise/registrations#new_gift'
    post 'signup_gift',             to: 'devise/registrations#create_gift'
    get 'signup_beneficiary',       to: 'devise/registrations#new_gift'
    post 'signup_beneficiary',      to: 'devise/registrations#create_gift'
    get "member/sent_mail",         to: "devise/passwords#sent_mail"
    put "member/update_cause",      to: "member/registrations#update_cause"
    put "member/update_profile",    to: "member/registrations#update_profile"
    put "member/stop_subscription", to: "member/registrations#stop_subscription"
  end

  namespace :member do
    resources :users, only: [:show, :update] do
      get "dashboard",  to: "dashboard#dashboard"
      get "profile",    to: "dashboard#profile"
      get "ambassador", to: "dashboard#ambassador"
      get "gift",       to: "dashboard#gift"
    end
    get "subscribe_gift", to: "subscribe#gift"
    resources :subscribe, only: [:new, :create, :update, :destroy]
    resources :perks, only: [:show]
  end

  get "map", to: "member/dashboard#dashboard"

  resources :users do
    resources :beneficiaries, only: [:create, :update]
  end

  devise_for :businesses, path: :pro, controllers: { passwords: :passwords }
  devise_scope :business do
    get "pro/sent_mail",        to: "devise/passwords#sent_mail"
    put "pro/update_business",  to: "pro/registrations#update_business"
  end

  namespace :pro do
    resources :businesses, only: [:show, :update, :new, :create] do
      resources :addresses
      resources :perks, only: [:index, :new, :create, :update]
      get 'dashboard',  to: 'dashboard#dashboard'
      post 'impersonation', to: 'dashboard#set_impersonation'
      get "profile",    to: "dashboard#profile"
      get "supervisor_dashboard", to: "dashboard#supervisor_dashboard"
    end
    resources :perks, only: [:show, :edit, :update, :destroy]
    resources :addresses, only: [:update]

    resources :activate, only: [:update, :destroy]
  end

  # namespace :asso do
  resources :causes, only: [:index, :show]
  #   get 'dashboard', to: 'dashboard#dashboard'
  # end

  resources :perks do
    resources :uses, only: [:create, :update]
  end

  resources :addresses do
    resources :timetables, only: [:create, :update]
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
