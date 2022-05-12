class TeamLeading < ApplicationRecord
  belongs_to :scrum_master
  belongs_to :team
end
