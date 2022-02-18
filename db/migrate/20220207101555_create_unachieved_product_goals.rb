class CreateUnachievedProductGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :unachieved_product_goals do |t|
      t.references :product_goal, type: :uuid, foreign_key: true
      t.datetime :created_at, null: false
    end
  end
end
