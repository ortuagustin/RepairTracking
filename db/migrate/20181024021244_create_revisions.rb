class CreateRevisions < ActiveRecord::Migration[5.2]
  def change
    create_table :revisions do |t|
      t.text :notes
      t.belongs_to :repair, foreign_key: true

      t.timestamps
    end
  end
end
