class CreateMovieProducers < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_producers do |t|
      t.references :movies, foreign_key: true
      t.references :producers, foreign_key: true

      t.timestamps
    end
  end
end
