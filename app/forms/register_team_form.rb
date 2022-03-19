class RegisterTeamForm
  include ActiveModel::Model

  attr_accessor :name

  validates :name, presence: true
  validate :must_have_valid_roles

  class << self
    def parameters
      [:name, roles_attributes: [:role]]
    end
  end

  def role_name_at(index)
    role_names[index]
  end

  def roles
    @roles ||= role_names.size.times.map { TeamMemberRole.new }
  end

  def roles_attributes=(roles_attrs)
    @roles = roles_attrs.each_with_object([]) do |(index, role_attr), list|
      list[index.to_i] = TeamMemberRole.new(role_attr)
    end
  end

  def selected_roles
    @roles.select { |r| r.role.present? }
  end

  private

  def must_have_valid_roles
    team_member = TeamMember.new(roles: selected_roles)
    roles_errors = team_member.tap(&:validate).errors.messages_for(:roles)

    if roles_errors.any?
      errors.add(:roles, *roles_errors)
    end
  end

  def role_names
    TeamMemberRole.roles.keys
  end
end
