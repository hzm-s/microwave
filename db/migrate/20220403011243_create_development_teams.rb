class CreateDevelopmentTeams < ActiveRecord::Migration[7.0]
  def change
    create_table :development_teams do |t|
      t.references :product, type: :uuid, null: false, foreign_key: true
      t.references :team, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :development_teams, [:team_id], unique: true, name: 'unique_index_development_teams_on_team_id'
  end
end
