class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :description
      t.references :poster, foreign_key: true
      t.string :age_limit
      t.integer :budget
      t.integer :box_office

      t.timestamps
    end
    add_index(:movies, :title)
  end
end
