class Team::MembersController < ApplicationController
  helper_method :current_team

  def new
    @form = TeamMemberForm.new
  end

  def create
    @form = TeamMemberForm.new(team_member_params)
    if @form.valid?
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
