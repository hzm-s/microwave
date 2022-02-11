class CreatePbis < ActiveRecord::Migration[7.0]
  def change
    create_table :pbis, id: :uuid do |t|
      t.references :product, type: :uuid, foreign_key: true
      t.string :description, null: false
      t.integer :size
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
