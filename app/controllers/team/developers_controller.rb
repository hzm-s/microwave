class Team::DevelopersController < ApplicationController
  helper_method :current_team

  def new
    @form = AddDeveloperForm.new(team: current_team, user: current_user).tap { _1.validate }
  end

  def create
    @form = AddDeveloperForm.new(team: current_team, user: current_user)
    if @form.valid? && (result = AddDeveloperUsecase.perform(team: current_team, user: current_user)).succeeded?
      redirect_to team_path(current_team)
    else
      result && @form.import_errors(result.team)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def current_team
    Team.find_by(id: params[:team_id])
  end
end
