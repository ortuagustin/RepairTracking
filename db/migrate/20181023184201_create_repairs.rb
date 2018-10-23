class CreateRepairs < ActiveRecord::Migration[5.2]
  def change
    create_table :repairs do |t|
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :artifact, foreign_key: true
      t.integer :estimated_days

      t.timestamps
    end
  end
end
