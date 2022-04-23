class CreateProductOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :product_owners do |t|
      t.references :product, type: :uuid, null: false, index: { unique: true }, foreign_key: true
      t.references :user, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
