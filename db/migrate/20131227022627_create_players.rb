class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :group_id, null: false

      t.timestamps
    end
  end
end
