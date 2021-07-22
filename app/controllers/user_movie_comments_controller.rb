class UserMovieCommentsController < ApplicationController

  before_action :find_user_movie_comment, except: %i[create index]
  before_action :permit_user_movie_comment_params, only: %i[create update]

  def index
    @user_movie_comments = UserMovieComment.filtering(params).page(page).per(per_page)
  end

  def show
    # authorize @user_movie_comments
  end




  def create
    @user_movie_comment = UserMovieComment.new(@permitted_params)
    #authorize @user_movie_comments
    if @user_movie_comment.save
      render status: :created
    else
      render json: { errors: @user_movie_comment.errors.messages }, status: 422
    end
  end

  def update
    unless @user_movie_comment.update(@permitted_params)
      #authorize @user_movie_comments
      render json: { errors: @user_movie_comment.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user_movie_comment.destroy
    #authorize @user_movie_comments
  end

  private

  def find_user_movie_comment
    @user_movie_comment = UserMovieComment.find_by_id params[:id]
    head :not_found unless @user_movie_comment
  end

  def permit_user_movie_comment_params
    @permitted_params = params.permit(:comment, :rating)
  end
end
