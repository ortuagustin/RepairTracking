class AddModelToArtifacts < ActiveRecord::Migration[5.2]
  def change
    add_column :artifacts, :model, :string
    add_index :artifacts, :model, unique: true
  end
end
