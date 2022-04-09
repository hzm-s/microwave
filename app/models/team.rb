class Team < ApplicationRecord
  has_many :members, -> { extending TeamMemberCollection }, class_name: 'TeamMember', dependent: :destroy
  has_one :development_team, dependent: :destroy

  attribute :name, :name

  validates :name, presence: true, domain_object: true
  validates :members, scrum_team_members: true

  def add_member(user:, roles:)
    self.members.build(user: user, roles: roles)
  end

  def member?(user_id)
    members.include_user?(user_id)
  end

  private

  def must_be_compliant_with_scrum_team_members
    if (members_errors = members.validate).any?
      error, options = *members_errors
      errors.add(:members, error)
    end
  end
end
