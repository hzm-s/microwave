class CreateCurrentProductGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :current_product_goals do |t|
      t.references :product_goal, type: :uuid, foreign_key: true
      t.references :product_backlog, type: :uuid, foreign_key: true

      t.timestamps
    end

    add_index :current_product_goals, [:product_goal_id, :product_backlog_id], unique: true, name: 'unique_key_curernt_product_goals'
  end
end
