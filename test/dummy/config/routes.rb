Rails.application.routes.draw do
  mount WildayUi::Engine => "/wilday_ui"

  namespace :components do
    namespace :button do
      get "/", to: "buttons#index"
      get "variant", to: "buttons#variant"
      get "icon", to: "buttons#icon"
      get "size", to: "buttons#size"
      get "radius", to: "buttons#radius"
      get "link", to: "buttons#link"
      get "loading", to: "buttons#loading"
      get "dropdown", to: "buttons#dropdown"
    end
  end
end
