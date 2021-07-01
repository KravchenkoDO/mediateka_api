class ActorsController < ApplicationController

  before_action :find_actor, except: %i[create index]

  def index
    @actors = Actor.all
  end

  def show; end

  def create
    @actor = Actor.new(first_name: params[:first_name], last_name: params[:last_name])
    render json: { errors: @actor.errors.messages }, status: 422 unless @actor.save
  end

  def update
    @actor = Actor.update(first_name: params[:first_name], last_name: params[:last_name])
    render json: { errors: @actor.errors.messages }, status: 422 unless @actor.save
  end

  def destroy
    @actor.destroy
  end

  def find_actor
    @actor = Actor.find_by_id params[:id]
    head :not_found unless @actor
  end
end
