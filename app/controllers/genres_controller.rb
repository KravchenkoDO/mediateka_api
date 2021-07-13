class GenresController < ApplicationController

  before_action :find_genre, except: %i[create index]
  before_action :permit_genre_params, only: %i[create update]

  def index
    @genres = Genre.filtering(params)
  end

  def show; end

  def create
    @genre = Genre.new(@permitted_params)
    return render json: { errors: @genre.errors.messages }, status: 422 unless @genre.save

    render status: :created
  end

  def update
    unless @genre.update(@permitted_params)
      render json: { errors: @genre.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @genre.destroy
  end

  private

  def find_genre
    @genre = Genre.find_by_id params[:id]
    head :not_found unless @genre
  end

  def permit_genre_params
    @permitted_params = params.permit(:title)
  end
end