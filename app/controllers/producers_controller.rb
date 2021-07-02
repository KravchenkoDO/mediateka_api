class ProducersController < ApplicationController

  before_action :find_producer, except: %i[create index]

  def index
    @producers = Producer.all
  end

  def show; end

  def create
    @producer = Producer.new(first_name: params[:first_name], last_name: params[:last_name])
    if @producer.save
      render status: :created
    else
      render json: { errors: @producer.errors.messages }, status: 422
    end
  end

  def update
    unless @producer.update(first_name: params[:first_name], last_name: params[:last_name])
      render json: { errors: @producer.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @producer.destroy
  end

  private

  def find_producer
    @producer = Producer.find_by_id params[:id]
    head :not_found unless @producer
  end
end
