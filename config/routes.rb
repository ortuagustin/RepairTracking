Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # scope "(:locale)", locale: /#{ I18n.locales.join("|")}/ do
    devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }, controllers: { sessions: 'users/sessions' }
    resources :customers
    resources :artifacts do
      resources :pieces
    end
    resources :repairs, except: [:delete] do
      get 'query', on: :collection
    end
  # end

  authenticated :user do
    root to: "home#dashboard", as: :authenticated_root
  end

  root to: "home#index"
end
