class CreateProductBacklogItems < ActiveRecord::Migration[7.0]
  def change
    create_table :product_backlog_items, id: :uuid do |t|
      t.references :product_backlog, type: :uuid,  foreign_key: true
      t.references :work, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
