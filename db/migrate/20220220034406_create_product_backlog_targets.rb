class CreateProductBacklogTargets < ActiveRecord::Migration[7.0]
  def change
    create_table :product_backlog_targets do |t|
      t.references :product_backlog, type: :uuid, foreign_key: true, index: { unique: true }
      t.references :unachieved_product_goal, foreign_key: true
      t.datetime :updated_at, null: false
    end
  end
end
