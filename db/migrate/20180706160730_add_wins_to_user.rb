class AddWinsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :wins, :integer
  end
end
