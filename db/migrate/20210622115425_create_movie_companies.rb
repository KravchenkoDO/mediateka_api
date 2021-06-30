class CreateMovieCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_companies do |t|
      t.references :movies, foreign_key: true
      t.references :companies, foreign_key: true

      t.timestamps
    end
  end
end
