class AddDetailsToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :x_coord, :y_coord, :integer
    add_column :type, :string
    add_column :captured?, :boolean
  end
end
