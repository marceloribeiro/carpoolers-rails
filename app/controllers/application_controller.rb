# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 25
  end

  def current_location
    return @current_location if @current_location.present?
    data = Geocoder.search(request.ip).first.data

    @current_location = [
      data['city'],
      data['region'],
      data['country']
    ].compact.join(', ')
  end
end
