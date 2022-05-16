module TeamSupport
  def create_team(name: default_team_name, po: nil, sm: nil, dev: [])
    Team.create!(name: name).tap do |t|
      #po && add_team_member(t, po, :po)
      #sm && add_team_member(t, sm, :sm)
      dev.each { add_developer(t, _1) }
    end
  end

  def add_developer(team, user)
    team.add_developer(user).tap { _1.save! }
  end

  def add_scrum_master(team, user)
    ScrumMaster.find_or_create_by(user: user).tap do
      _1.add_team(team)
      _1.save!
    end
  end

  private

  def default_team_name
    "the team #{Team.count + 1}"
  end
end

RSpec.configure do |c|
  c.include TeamSupport
end
