class MoviesController < ApplicationController
  include Pundit
  before_action :find_movie, except: %i[create index]
  before_action :permit_movie_params, only: %i[create update]

  def index
    @movies = Movie.filtering(params)
  end

  def show
    authorize @movie
  end

  def create
    @movie = Movie.new(@permitted_params)
    if @movie.save
      render status: :created
    else
      render json: { errors: @movie.errors.messages }, status: 422
    end
  end

  def update
    unless @movie.update(@permitted_params)
      render json: { errors: @movie.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
  end

  private

  def find_movie
    @movie = Movie.find_by_id params[:id]
    head :not_found unless @movie
  end

  def permit_movie_params
    @permitted_params = params.permit(:title, :description, :age_limit, :budget, :box_office)
  end
end
