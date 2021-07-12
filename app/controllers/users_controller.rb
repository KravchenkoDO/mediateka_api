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
    unless @user.update(first_name: params[:first_name], last_name: params[:last_name],
                        nickname: params[:nickname], role: params[:role], email: params[:email])
      render json: { errors: @user.errors.messages }, status: :unprocessable_entity
    end
  end

  # DELETE /users/:id
  def destroy
    @user.destroy
  end

  # POST /users
  def create
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name], nickname: params[:nickname],
                     role: params[:role], email: params[:email], password: params[:password])
    if @user.save
      render status: :created
    else
      render json: { errors: @user.errors.messages }, status: 422
    end
  end

  private

  def find_user
    @user = User.find_by_id params[:id]
    head :not_found unless @user
  end
end