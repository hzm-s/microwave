class AddDeveloperUsecase < BaseUsecase
  def perform(team:, user:)
    team.add_developer(user)

    if team.save
      succeeded
    else
      failed(team: team)
    end
  end
end
