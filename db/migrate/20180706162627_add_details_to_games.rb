class AddDetailsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :name, :state, :string
    add_column :turn, :integer
  end
end
