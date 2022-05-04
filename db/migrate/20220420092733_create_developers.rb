class CreateDevelopers < ActiveRecord::Migration[7.0]
  def change
    create_table :developers do |t|
      t.references :user, type: :uuid, null: false, index: { unique: true }, foreign_key: true
      t.references :team, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
