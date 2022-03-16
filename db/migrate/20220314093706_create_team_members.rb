class CreateTeamMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_members do |t|
      t.references :team, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true
      t.integer :role, null: false

      t.timestamps
    end
  end
end
