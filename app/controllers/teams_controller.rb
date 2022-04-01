class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def new
    @form = RegisterTeamForm.new
  end

  def create
    @form = RegisterTeamForm.new(register_params)
    if @form.valid? && create_team(current_user, @form).succeeded?
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def create_team(user, form)
    RegisterTeamWithMemberUsecase.perform(
      name: form.name,
      user: user,
      roles: form.selected_roles,
    )
  end

  def register_params
    params.require(:form).permit(*RegisterTeamForm.parameters)
  end
end
