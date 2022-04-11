class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.string :vision, null: false
      t.uuid :owner_id, null: false

      t.timestamps
    end

    add_foreign_key :products, :users, column: :owner_id
  end
end
