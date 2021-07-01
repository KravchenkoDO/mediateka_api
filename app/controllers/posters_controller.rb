class PostersController < ApplicationController

  before_action :find_poster, except: %i[create index]

  def index
    @posters = Poster.all
  end

  def show; end

  def create
    @poster = Poster.new(link: params[:link])
    render json: { errors: @poster.errors.messages }, status: 422 unless @poster.save
  end

  def update
    @poster = Poster.update(link: params[:link])
    render json: { errors: @poster.errors.messages }, status: 422 unless @poster.save
  end

  def destroy
    @poster.destroy
  end

  def find_poster
    @poster = Poster.find_by_id params[:id]
    head :not_found unless @poster
  end
end
