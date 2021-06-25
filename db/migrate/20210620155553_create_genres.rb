class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :title, null: false

      t.timestamps
    end
    add_index(:genres, :title)
  end
end
