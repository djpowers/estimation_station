class ChangeGroupToGame < ActiveRecord::Migration
  def change
    rename_table :groups, :games
  end
end
