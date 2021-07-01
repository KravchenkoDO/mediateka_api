class GenresController < ApplicationController

  before_action :find_genre, except: %i[create index]

  def index
    @genres = Genre.all
  end

  def show; end

  def create
    @genre = Genre.new(title: params[:title])
    render json: { errors: @genre.errors.messages }, status: 422 unless @genre.save
  end

  def update
    @genre = Genre.update(title: params[:title])
    render json: { errors: @genre.errors.messages }, status: 422 unless @genre.save
  end

  def destroy
    @genre.destroy
  end

  def find_genre
    @genre = Genre.find_by_id params[:id]
    head :not_found unless @genre
  end
end
