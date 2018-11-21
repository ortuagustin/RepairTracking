class CreatePieces < ActiveRecord::Migration[5.2]
  def change
    create_table :pieces do |t|
      t.string :name
      t.string :description
      t.belongs_to :artifact, foreign_key: true

      t.timestamps
    end
  end
end
