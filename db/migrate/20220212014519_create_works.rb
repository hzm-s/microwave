class CreateWorks < ActiveRecord::Migration[7.0]
  def change
    create_table :works, id: :uuid do |t|
      t.references :product, type: :uuid, foreign_key: true
      t.references :product_goal, type: :uuid, foreign_key: true
      t.integer :number, null: false
      t.integer :status, null: false, default: 0
      t.string :description, null: false
      t.integer :size

      t.timestamps
    end

    add_index :works, [:product_id, :number], unique: true
  end
end
