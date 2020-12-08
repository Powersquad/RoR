class CreateCart < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.belongs_to :employee
      t.integer :productCount, null: false, default: 0
      t.integer :total, null: false, default: 0
      t.text :cart, null: false, default: "{}"
    end
  end
end
