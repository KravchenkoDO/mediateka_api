# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  enum role: %w[guest user admin]

  def self.filtering(params)
    like(:first_name, params[:first_name])
      .like(:last_name, params[:last_name])
      .like(:nickname, params[:nickname])
      .like(:role, params[:role])
      .like(:email, params[:email])
      .less_or_equal(:created_at, params[:created_at_from])
      .greater_or_equal(:created_at, params[:created_at_to])
      .ordering_by_params(params[:field_name] || :created_at, params[:order_type] || :desc)
  end
end
