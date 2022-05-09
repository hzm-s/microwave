class Team::DevelopersController < ApplicationController
  helper_method :current_team

  def index
    @developers = Developer.where(team_id: current_team.id)
  end

  def create
    result = AddDeveloperUsecase.perform(team: current_team, user: current_user)
    if result.succeeded?
      render :create
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def current_team
    Team.find_by(id: params[:team_id])
  end
end
