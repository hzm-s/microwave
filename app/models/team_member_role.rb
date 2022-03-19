class TeamMemberRole < ApplicationRecord
  belongs_to :team_member

  enum :role, { product_owner: 0, developer: 1, scrum_master: 2 }
end
