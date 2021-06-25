class CreateMovieGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_genres do |t|
      t.references :movies, foreign_key: true, type: :uuid
      t.references :genres, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
