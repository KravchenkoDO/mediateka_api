class CreateUserFollowGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :user_follow_genres do |t|
      t.references :users, foreign_key: true, type: :uuid
      t.references :genres, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
