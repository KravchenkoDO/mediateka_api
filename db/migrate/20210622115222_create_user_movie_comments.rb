class CreateUserMovieComments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_movie_comments do |t|
      t.references :movies, foreign_key: true, type: :uuid
      t.references :users, foreign_key: true, type: :uuid
      t.string :comments, null: false

      t.timestamps
    end
  end
end
