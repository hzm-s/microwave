module TeamSupport
  ROLE_LONG_NAMES = {
    po: :product_owner,
    dev: :developer,
    sm: :scrum_master,
  }

  def create_team(name: 'the team')
    Team.create!(name: name)
  end

  def team_member(user, *role_short_names)
    TeamMember.new(user: user, roles: team_member_roles(*role_short_names))
  end

  def team_member_roles(*role_short_names)
    role_short_names
      .map { ROLE_LONG_NAMES[_1] }
      .map { TeamMemberRole.new(role: _1) }
  end
end

RSpec.configure do |c|
  c.include TeamSupport
end
