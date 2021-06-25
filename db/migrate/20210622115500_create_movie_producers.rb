class CreateMovieProducers < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_producers do |t|
      t.references :movies, foreign_key: true, type: :uuid
      t.references :producers, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
