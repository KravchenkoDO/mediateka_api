class CreateMovieActors < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_actors do |t|
      t.references :movies, foreign_key: true, type: :uuid
      t.references :actors, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
