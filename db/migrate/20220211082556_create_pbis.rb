class CreatePbis < ActiveRecord::Migration[7.0]
  def change
    create_table :pbis, id: :uuid do |t|
      t.references :product_goal, type: :uuid, foreign_key: true
      t.integer :status, null: false, default: 0
      t.string :description, null: false
      t.integer :size

      t.timestamps
    end
  end
end
