class MoviesController < ApplicationController

  before_action :find_movie, except: %i[create index]

  def index
    @movies = Movie.filtering(params)
  end

  def show; end

  def create
    @movie = Movie.new(title: params[:title], description: params[:description], age_limit: params[:age_limit],
                       budget: params[:budget], box_office: params[:box_office])
    if @movie.save
      render status: :created
    else
      render json: { errors: @movie.errors.messages }, status: 422
    end
  end

  def update
    unless @movie.update(title: params[:title], description: params[:description], age_limit: params[:age_limit],
                         budget: params[:budget], box_office: params[:box_office])
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
end
