module TeamSupport
  ROLE_LONG_NAMES = {
    po: :product_owner,
    dev: :developer,
    sm: :scrum_master,
  }

  def create_team(name: 'the team', po: nil, sm: nil, dev: [])
    Team.create!(name: name).tap do |t|
      po && add_team_member(t, po, :po)
      sm && add_team_member(t, sm, :sm)
      dev.each { add_team_member(t, _1, :dev) }
    end
  end

  def add_team_member(team, user, *role_short_names)
    team.add_member(user: user, roles: team_member_roles(*role_short_names)).tap { _1.save! }
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
