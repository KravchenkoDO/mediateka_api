class CreateUserFavoriteMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :user_favorite_movies do |t|
      t.references :user, foreign_key: true
      t.references :movie, foreign_key: true

      t.timestamps
    end
  end
end
