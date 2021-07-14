class ActorsController < ApplicationController

  before_action :find_actor, except: %i[create index]
  before_action :permit_actor_params, only: %i[create update]

  def index
    @actors = Actor.filtering(params).page(page).per(per_page)
  end

  def show; end

  def create
    @actor = Actor.new(@permitted_params)
    if @actor.save
      render status: :created
    else
      render json: { errors: @actor.errors.messages }, status: 422
    end
  end

  def update
    unless @actor.update(@permitted_params)
      render json: { errors: @actor.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @actor.destroy
  end

  private

  def find_actor
    @actor = Actor.find_by_id params[:id]
    head :not_found unless @actor
  end

  def permit_actor_params
    @permitted_params = params.permit(:first_name, :last_name)
  end
end
