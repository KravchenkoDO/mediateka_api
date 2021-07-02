class ProducersController < ApplicationController

  before_action :find_producer, except: %i[create index]

  def index
    @producers = Producer.all
  end

  def show; end

  def create
    @producer = Producer.new(first_name: params[:first_name], last_name: params[:last_name])
    render json: { errors: @producer.errors.messages }, status: 422 unless @producer.save
  end

  def update
    @producer = Produser.update(first_name: params[:first_name], last_name: params[:last_name])
    render json: { errors: @producer.errors.messages }, status: 422 unless @producer.save
  end

  def destroy
    @producer.destroy
  end

  def find_actor
    @producer = Actor.find_by_id params[:id]
    head :not_found unless @producer
  end
end
