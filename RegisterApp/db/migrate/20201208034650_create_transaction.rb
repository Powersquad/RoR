class CreateTransaction < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.belongs_to :employee
      t.integer :productCount, null: false, default: 0
      t.integer :total, null: false, default: 0
      t.text :trans, null: false, default: "{}"
    end
  end
end
