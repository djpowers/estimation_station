class ChangeGroupToGame < ActiveRecord::Migration
  def change
    rename_table :groups, :games
    rename_column :jars, :group_id, :game_id
    rename_column :players, :group_id, :game_id
  end
end
