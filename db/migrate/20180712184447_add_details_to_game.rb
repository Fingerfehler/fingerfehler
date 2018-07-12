class AddDetailsToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :white_player_id, :integer
    add_column :games, :black_player_id, :integer
    add_column :games, :piece_id, :integer
  end
end
