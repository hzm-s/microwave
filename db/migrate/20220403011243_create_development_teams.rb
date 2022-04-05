class CreateDevelopmentTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :development_teams do |t|
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.references :team, type: :uuid, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
