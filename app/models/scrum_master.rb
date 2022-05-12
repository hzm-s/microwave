class ScrumMaster < ApplicationRecord
  belongs_to :user
  has_many :leadings, class_name: 'TeamLeading', dependent: :destroy
  has_many :teams, through: :leadings

  validate do
    if teams.size != teams.uniq.size
      errors.add(:base, :duplicated_team)
    end
  end

  def add_team(team)
    teams << team
  end
end
