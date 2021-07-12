class User < ActiveRecord::Base
  extend Devise::Models
  #
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  # model scoups
  scope :like, -> (key, value) { where("#{key} ILIKE ?", "%#{value}%") if value.present? }
  scope :less_or_equal, -> (key, value) { where("#{key} <= ?", "#{value}") if value.present? }
  scope :greater_or_equal, -> (key, value) { where("#{key} >= ?", "#{value}") if value.present? }
  scope :pagination, -> (page, per_page) { limit(per_page).offset(per_page.to_i * (page.to_i - 1)) }
  scope :ordering_by_params, -> (field_name, order_type) { order("#{field_name} #{order_type}") }

  def self.filtering(params)
    like(:first_name, params[:first_name])
      .like(:last_name, params[:last_name])
      .like(:nickname, params[:nickname])
      .like(:role, params[:role])
      .like(:email, params[:email])
      .less_or_equal(:created_at, params[:created_at_from])
      .greater_or_equal(:created_at, params[:created_at_to])
      .pagination(params[:page] || 1, params[:per_page] || 10)
      .ordering_by_params(params[:field_name] || :created_at, params[:order_type] || :desc)
  end
end

