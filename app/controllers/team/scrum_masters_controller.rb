class Team::ScrumMastersController < ApplicationController
  helper_method :current_team, :current_scrum_master

  def show
    @scrum_master = ScrumMaster.joins(:leadings).find_by(team_leadings: { team_id: params[:team_id] })
  end

  def create
    @scrum_master = ScrumMaster.find_or_initialize_by(user_id: current_user.id)
    @scrum_master.add_team(current_team)
    if @scrum_master.save
    else
      render :create, status: :unprocessable_entity
    end
  end

  private

  def current_team
    @current_team ||= Team.find_by(id: params[:team_id])
  end

  def current_scrum_master
    @current_scrum_master = ScrumMaster.find_by(user_id: current_user.id)
  end
end
