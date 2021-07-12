class UsersController < ApplicationController
  #before_action :autenticate_user, unless: :verify_api
  before_action :find_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.filtering(params)
  end

  # GET /users/:id
  def show; end

  # PUT /users/:id
  def update
    unless @user.update(user_params)
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render status: :created
    else
      render json: { errors: @user.errors.messages }, status: 422
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :role, :email, :password, :nickname )
  end

  def find_user
    @user = User.find_by_id params[:id]
    head :not_found unless @user
  end
end
