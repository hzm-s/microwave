class Team::MembersController < ApplicationController
  helper_method :current_team

  def new
    @form = TeamMemberForm.new
  end

  def create
    @form = TeamMemberForm.new(team_member_params)
    if @form.valid? && (result = add_team_member).succeeded?
    else
      result && @form.import_errors(result.team)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def add_team_member
    AddTeamMemberUsecase.perform(
      team: current_team,
      user: current_user,
      roles: @form.selected_roles
    )
  end

  def current_team
    Team.find_by(id: params[:team_id])
  end

  def team_member_params
    params.require(:form).permit(*TeamMemberForm.parameters)
  end
end
