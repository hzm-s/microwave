class TeamsController < ApplicationController
  def new
    @team = Team.new
  end
end
