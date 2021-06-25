class CreatePosters < ActiveRecord::Migration[6.1]
  def change
    create_table :posters do |t|
      t.string :link

      t.timestamps
    end
  end
end
