# frozen_string_literal: true

class ApplicationController < ActionController::Base
  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 25
  end
end
