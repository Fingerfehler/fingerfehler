class AddDetailsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :name, :string
    add_column :games, :state, :string
    add_column :games, :turn, :integer
  end
end
