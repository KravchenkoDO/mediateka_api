class CreateActors < ActiveRecord::Migration[6.1]
  def change
    create_table :actors do |t|
      t.string :firstname
      t.string :lastname, null: false

      t.timestamps
    end
    add_index(:actors, :lastname)
  end
end
