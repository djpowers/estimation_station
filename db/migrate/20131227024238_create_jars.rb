class CreateJars < ActiveRecord::Migration
  def change
    create_table :jars do |t|
      t.string :contents, null: false
      t.integer :quantity, null: false
      t.integer :game_id, null: false

      t.timestamps
    end
  end
end
