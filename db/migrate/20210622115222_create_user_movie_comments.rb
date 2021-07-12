class CreateUserMovieComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_movie_comments do |t|
      t.references :movies, foreign_key: true
      t.references :users, foreign_key: true
      t.string :comment

      t.timestamps
    end
  end
end
