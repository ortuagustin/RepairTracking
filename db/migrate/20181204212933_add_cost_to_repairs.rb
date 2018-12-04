class AddCostToRepairs < ActiveRecord::Migration[5.2]
  def change
    add_column :repairs, :cost, :decimal, precision: 10, scale: 2, default: 0
  end
end
