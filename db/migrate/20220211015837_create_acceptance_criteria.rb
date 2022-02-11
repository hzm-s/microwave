class CreateAcceptanceCriteria < ActiveRecord::Migration[7.0]
  def change
    create_table :acceptance_criteria, id: :uuid do |t|
      t.references :pbi, type: :uuid, foreign_key: true
      t.string :content, null: false
      t.boolean :satisfied, null: false, default: false

      t.timestamps
    end
  end
end
