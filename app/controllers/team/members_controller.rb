class Team::MembersController < ApplicationController
  helper_method :current_team

  def new
    @form = TeamMemberForm.new
  end

  def create
    @form = TeamMemberForm.new(team_member_params)
    if @form.valid?
      team_member = TeamMember.new(user: current_user, roles: @form.selected_roles)
      current_team.add_member(team_member)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def current_team
    Team.find_by(id: params[:team_id])
  end

  def team_member_params
    params.require(:form).permit(*TeamMemberForm.parameters)
  end
end
