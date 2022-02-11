class CreateCurrentProductGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :current_product_goals do |t|
      t.references :product, type: :uuid, foreign_key: true
      t.references :product_goal, type: :uuid, foreign_key: true, index: { unique: true }

      t.datetime :created_at, null: false
    end
  end
end
