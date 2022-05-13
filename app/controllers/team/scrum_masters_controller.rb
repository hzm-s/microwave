class Team::ScrumMastersController < ApplicationController
  def show
    @scrum_master = ScrumMaster.joins(:leadings).find_by(team_leadings: { team_id: params[:team_id] })
  end
end
