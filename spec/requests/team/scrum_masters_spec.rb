require 'rails_helper'

describe '/team/:team_id/scrum_master' do
  let(:user) { sign_up }
  let(:team) { create_team }

  before do
    sign_in(user)
  end

  describe 'show' do
    it do
      add_scrum_master(team, user)

      get team_scrum_master_path(team_id: team.id)

      expect(response.body).to include user.name
    end
  end

  describe 'create' do
    context 'precondition is satisfied' do
      it do
        post team_scrum_master_path(team_id: team.id, format: :turbo_stream)

        get team_scrum_master_path(team_id: team.id)
        expect(response.body).to include user.name
      end
    end
  end
end
