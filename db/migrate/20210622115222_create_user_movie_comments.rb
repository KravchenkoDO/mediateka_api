class CreateUserMovieComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_movie_comments do |t|
      t.references :movie, foreign_key: true
      t.references :user, foreign_key: true
      t.string :comment, null: false

      t.timestamps
    end
  end
end
