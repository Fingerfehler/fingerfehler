class AddDetailsToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :x_coord, :integer
    add_column :pieces, :y_coord, :integer
    add_column :pieces, :type, :string
    add_column :pieces, :captured?, :boolean
    add_column :pieces, :white?, :boolean
  end
end
