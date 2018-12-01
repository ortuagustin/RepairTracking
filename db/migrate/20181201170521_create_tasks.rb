class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :name
      t.string :description
      t.decimal :cost, precision: 10, scale: 2
      t.belongs_to :artifact, foreign_key: true

      t.timestamps
    end
  end
end
