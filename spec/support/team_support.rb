module TeamSupport
  def create_team(name: 'the team', po: nil, sm: nil, dev: [])
    Team.create!(name: name).tap do |t|
      #po && add_team_member(t, po, :po)
      #sm && add_team_member(t, sm, :sm)
      dev.each { add_developer(t, _1) }
    end
  end

  def add_developer(team, user)
    team.add_developer(user).tap { _1.save! }
  end
end

RSpec.configure do |c|
  c.include TeamSupport
end
