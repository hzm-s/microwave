class CreateProductDevelopments < ActiveRecord::Migration[7.0]
  def change
    create_table :product_developments do |t|
      t.references :product, type: :uuid, null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
