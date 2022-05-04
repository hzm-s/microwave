class CreateTeamLeadings < ActiveRecord::Migration[7.0]
  def change
    create_table :team_leadings do |t|
      t.references :scrum_master, null: false, foreign_key: true
      t.references :team, type: :uuid, null: false, foreign_key: true

      t.timestamps

      t.index [:scrum_master_id, :team_id], unique: true
    end
  end
end
