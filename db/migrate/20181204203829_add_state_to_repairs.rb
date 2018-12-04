class AddStateToRepairs < ActiveRecord::Migration[5.2]
  def change
    add_column :repairs, :state, :string, default: 'PENDIENTE'
  end
end
