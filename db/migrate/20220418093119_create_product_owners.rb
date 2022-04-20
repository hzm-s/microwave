class CreateProductOwners < ActiveRecord::Migration[7.0]
  def change
    create_table :product_owners do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :product_development, null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
