class AddTeamMemberUsecase < BaseUsecase
  def perform(team:, user:, roles:)
    team.add_member(user: user, roles: roles)

    if team.save
      succeeded
    else
      failed(team: team)
    end
  end
end
