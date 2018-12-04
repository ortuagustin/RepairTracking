class AddCostToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :cost, :decimal, precision: 10, scale: 2, default: 0
  end
end
