class AddDefaultTurnToGame < ActiveRecord::Migration[5.0]
  def change
    change_column :games, :turn, :integer, default: 0
  end
end
