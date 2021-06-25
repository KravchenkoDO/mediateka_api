class CreateUserFavoriteMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :user_favorite_movies do |t|
      t.references :users, foreign_key: true, type: :uuid
      t.references :movies, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
