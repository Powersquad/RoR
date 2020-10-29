class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.integer :employeeId, null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.string :firstName, null: false, default: ""
      t.string :lastName, null: false, default: ""
      t.boolean :active, default: false 
      t.integer :classification, null: false
      t.integer :manager_id, null: true, default: 0
      t.timestamps
    end
    
    add_index :employees, :employeeId, unique: true
    add_index :employees, :active
  end
end
