class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :lookupCode, null: false, default: ""
      t.integer :count, null: false, default: 0
      t.float :price, null: false, default: 0.0
      t.timestamps
    end

    add_index :products, :lookupCode, unique: true
  end
end
