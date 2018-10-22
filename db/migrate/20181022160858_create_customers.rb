class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :surname
      t.string :phone
      t.string :email
      t.text :notes

      t.timestamps
    end
  end
end
