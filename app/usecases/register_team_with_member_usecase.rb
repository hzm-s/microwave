class RegisterTeamWithMemberUsecase < BaseUsecase
  def perform(name:, user:, roles:)
    team = Team.new(name: name)
    team.add_member(TeamMember.new(user: user, roles: roles))

    if team.save
      succeeded(team: team)
    else
      failed
    end
  end
end
