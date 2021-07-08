class ActorsController < ApplicationController

  before_action :find_actor, except: %i[create index]

  def index
    @actors = Actor.filtering(params)
  end

  def show; end

  def create
    @actor = Actor.new(first_name: params[:first_name], last_name: params[:last_name])
    if @actor.save
      render status: :created
    else
      render json: { errors: @actor.errors.messages }, status: 422
    end
  end

  def update
    unless @actor.update(first_name: params[:first_name], last_name: params[:last_name])
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
end
