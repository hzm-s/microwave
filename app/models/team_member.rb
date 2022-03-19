class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :roles, class_name: 'TeamMemberRole'

  validates :roles, team_member_role_set: true
end
