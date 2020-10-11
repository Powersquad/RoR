class AddEmployeeColumns < ActiveRecord::Migration[6.0]
  def change
    change_table :employees do |t|
      t.string :firstName, null: false, default: ""
      t.string :lastName, null: false, default: ""
      t.boolean :active, null: false, default: false
      t.integer :classification, null: false
      t.integer :manager_id, null: true, default: 0

    end
    
  end
end
