class ScrumMaster < ApplicationRecord
  belongs_to :user
  has_many :leadings, class_name: 'TeamLeading', dependent: :destroy
  has_many :teams, through: :leadings

  delegate :avatar_url, :name, to: :user

  validate do
    team_ids = leadings.map(&:team_id)
    if team_ids.size != team_ids.uniq.size
      errors.add(:base, :duplicated_team)
    end
  end

  def add_team(team)
    self.leadings.build(team: team)
  end
end
