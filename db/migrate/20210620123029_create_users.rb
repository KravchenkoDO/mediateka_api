class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :role, null: false, default: 'guest'

      t.timestamps
    end
    add_index(:users, :email)
  end
end
