class CreateActors < ActiveRecord::Migration[6.1]
  def change
    create_table :actors do |t|
      t.string :first_name
      t.string :last_name, null: false

      t.timestamps
    end
    add_index(:actors, :last_name)
  end
end
