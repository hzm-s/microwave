class TeamMemberForm
  include ActiveModel::Model
  include TeamMemberRolesAccessible

  validate :must_have_valid_roles

  def self.parameters
    [team_member_roles_parameters]
  end

  def import_errors(team)
    errors.add(:base, *team.errors[:members])
  end
end
