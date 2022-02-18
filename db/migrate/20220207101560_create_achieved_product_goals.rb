class CreateAchievedProductGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :achieved_product_goals do |t|
      t.references :product_goal, type: :uuid, foreign_key: true
      t.datetime :achieved_at, null: false
    end
  end
end
