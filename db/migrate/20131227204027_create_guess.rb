class CreateGuess < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :quantity, null: false
      t.integer :player_id, null: false
      t.integer :jar_id, null: false

      t.timestamps
    end
  end
end
