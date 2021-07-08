class PostersController < ApplicationController

  before_action :find_poster, except: %i[create index]

  def index
    @posters = Poster.all
  end

  def show; end

  def create
    @poster = Poster.new(id: params[:id], link: params[:link])
    if @poster.save
      render status: :created
    else
      render json: { errors: @poster.errors.messages }, status: 422
    end
  end

  def update
    unless @poster.update(id: params[:id], link: params[:link])
      render json: { errors: @poster.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @poster.destroy
  end

  private

  def find_poster
    @poster = Poster.find_by_id params[:id]
    head :not_found unless @poster
  end
end
