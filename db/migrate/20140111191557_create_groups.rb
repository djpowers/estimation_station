class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :title, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
