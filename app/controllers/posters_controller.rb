class PostersController < ApplicationController

  before_action :find_poster, except: %i[create index]
  before_action :permit_poster_params, only: %i[create update]

  def index
    @posters = Poster.all.page(page).per(per_page)
  end

  def show
    #authorize @posters
  end



  def create
    @poster = Poster.new(@permitted_params)
    #authorize @posters
    if @poster.save
      render status: :created
    else
      render json: { errors: @poster.errors.messages }, status: 422
    end
  end

  def update
    unless @poster.update(@permitted_params)
      #authorize @posters
      render json: { errors: @poster.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @poster.destroy
    #authorize @posters
  end

  private

  def find_poster
    @poster = Poster.find_by_id params[:id]
    head :not_found unless @poster
  end

  def permit_poster_params
    @permitted_params = params.permit(:link)
  end
end
