class ComponentsController < ApplicationController
  # Debug helper inclusion
  puts "Including ButtonHelper into ComponentsController"
  include WildayUi::Components::Button::ButtonHelper

  def button
  end
end
