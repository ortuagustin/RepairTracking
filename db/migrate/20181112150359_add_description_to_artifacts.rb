class AddDescriptionToArtifacts < ActiveRecord::Migration[5.2]
  def change
    add_column :artifacts, :description, :string
  end
end
