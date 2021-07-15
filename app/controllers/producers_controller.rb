class ProducersController < ApplicationController

  before_action :find_producer, except: %i[create index]
  before_action :permit_producer_params, only: %i[create update]

  def index
    @producers = Producer.filtering(params).page(page).per(per_page)
  end

  def show; end

  authorize @producers

  def create
    @producer = Producer.new(@permitted_params)
    authorize @producers
    if @producer.save
      render status: :created
    else
      render json: { errors: @producer.errors.messages }, status: 422
    end
  end

  def update
    unless @producer.update(@permitted_params)
      authorize @producers
      render json: { errors: @producer.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @producer.destroy
    authorize @producers
  end

  private

  def find_producer
    @producer = Producer.find_by_id params[:id]
    head :not_found unless @producer
  end

  def permit_producer_params
    @permitted_params = params.permit(:first_name, :last_name)
  end
end
