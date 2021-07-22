class CreateMovieCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_companies do |t|
      t.belongs_to :movie
      t.belongs_to :company

      t.timestamps
    end
  end
end
