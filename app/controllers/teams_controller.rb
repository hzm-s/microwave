class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @form = RegisterTeamForm.new
  end

  def create
    @form = RegisterTeamForm.new(register_params)
    if @form.valid?
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def register_params
    params.require(:form).permit(*RegisterTeamForm.parameters)
  end
end
