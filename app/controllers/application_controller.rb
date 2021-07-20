# frozen_string_literal: true

class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include Pundit

  #
  # def authenticate_current_user
  #   head :unauthorized if current_user.nil?
  # end
  #
  # def current_user
  #   @current_user ||= User.find_by(email: headers["uid"])
  # end

  private

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 10
  end
end
