class CreateProductGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :product_goals, id: :uuid do |t|
      t.references :product, type: :uuid, foreign_key: true
      t.string :content, null: false
      t.datetime :updated_at
    end
  end
end
