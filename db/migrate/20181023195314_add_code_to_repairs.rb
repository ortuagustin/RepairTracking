class AddCodeToRepairs < ActiveRecord::Migration[5.2]
  def change
    add_column :repairs, :code, :string
    add_index :repairs, :code, unique: true
  end
end
