class Team::DevelopersController < ApplicationController
  helper_method :current_team

  def create
    result = AddDeveloperUsecase.perform(team: current_team, user: current_user)
    if result.succeeded?
    else
      @errors = result.team.errors
      render :new, status: :unprocessable_entity
    end
  end

  private

  def current_team
    Team.find_by(id: params[:team_id])
  end
end
