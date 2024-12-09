Rails.application.routes.draw do
  mount WildayUi::Engine => "/wilday_ui"

  get "/components/button", to: "components#button"
end
