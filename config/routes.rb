Rails.application.routes.draw do
  # Authentication
  resource :session
  resources :passwords, param: :token

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Public routes
  root "pages#home"
  get "about", to: "pages#about"

  resources :projects, only: [ :index, :show ], param: :slug

  # Blog
  scope "blog" do
    get "/", to: "posts#index", as: :blog
    get "feed", to: "posts#feed", as: :blog_feed, defaults: { format: :rss }
    get "category/:slug", to: "posts#category", as: :blog_category
    get ":slug", to: "posts#show", as: :blog_post
  end

  # Contact
  get "contact", to: "contacts#new"
  post "contact", to: "contacts#create"
  get "contact/thank-you", to: "contacts#thank_you", as: :contact_thank_you

  # Experience
  get "experience", to: "experiences#index"

  # Newsletter
  post "subscribe", to: "subscribers#create"
  get "unsubscribe/:token", to: "subscribers#unsubscribe", as: :unsubscribe

  # Sitemap
  get "sitemap", to: "sitemap#index", defaults: { format: :xml }, as: :sitemap

  # Admin namespace
  namespace :admin do
    root to: "dashboard#index"

    resource :profile, only: [ :edit, :update ]

    resources :projects do
      member { patch :reorder }
    end

    resources :experiences
    resources :educations
    resources :skills
    resources :social_links

    resources :posts do
      member do
        patch :publish
        patch :unpublish
      end
    end

    resources :categories
    resources :testimonials

    resources :contacts, only: [ :index, :show, :update, :destroy ] do
      member { patch :mark_read }
    end

    resources :subscribers, only: [ :index, :destroy ] do
      collection { post :export }
    end
  end
end
