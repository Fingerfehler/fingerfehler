class AddMoveCountToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :move_count, :integer
  end
end
