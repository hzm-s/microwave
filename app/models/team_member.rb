class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user

  enum :role, { product_owner: 0, developer: 1, scrum_master: 2 }
end
