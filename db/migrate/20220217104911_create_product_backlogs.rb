class CreateProductBacklogs < ActiveRecord::Migration[7.0]
  def change
    create_table :product_backlogs, id: :uuid do |t|
      t.references :product, type: :uuid, foreign_key: true, index: { unique: true }
      t.references :unachieved_product_goal, foreign_key: true
      t.timestamps
    end
  end
end
