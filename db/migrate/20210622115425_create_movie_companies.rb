class CreateMovieCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_companies do |t|
      t.references :movies, foreign_key: true, type: :uuid
      t.references :companies, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
