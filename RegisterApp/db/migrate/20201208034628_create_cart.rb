class CreateCart < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :lookupCode, null: false, default: ""
      t.integer :count, null: false, default: 0
      t.integer :total, null: false, default: 0
    end
  end
end
