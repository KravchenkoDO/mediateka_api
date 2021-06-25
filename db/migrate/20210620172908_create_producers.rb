class CreateProducers < ActiveRecord::Migration[6.1]
  def change
    create_table :producers do |t|
      t.string :first_name
      t.string :last_name, null: false

      t.timestamps
    end
    add_index(:producers, :last_name)
  end
end
