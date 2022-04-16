class CreateTeamMemberRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :team_member_roles do |t|
      t.references :team_member, foreign_key: true
      t.integer :role, null: false

      t.timestamps
    end
    add_index :team_member_roles, [:team_member_id, :role], unique: true
  end
end
