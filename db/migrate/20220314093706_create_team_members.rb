class CreateTeamMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :team_members do |t|
      t.references :team, type: :uuid, foreign_key: true
      t.references :user, type: :uuid, foreign_key: true

      t.timestamps
    end
    add_index :team_members, [:user_id], unique: true, name: 'unique_key_team_members_on_user_id'
  end
end
