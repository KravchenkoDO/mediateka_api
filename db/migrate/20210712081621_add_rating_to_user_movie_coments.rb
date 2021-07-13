class AddRatingToUserMovieComents < ActiveRecord::Migration[6.1]
  def change
    add_column :user_movie_comments, :rating, :integer
  end
end
