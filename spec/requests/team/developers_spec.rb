require 'rails_helper'

describe '/team/:team_id/developers' do
  let(:user) { sign_up }
  let(:team) { create_team }

  before { sign_in(user) }

  describe 'index' do
    it do
      add_developer(team, user)

      get team_developers_path(team_id: team.id)
      expect(response.body).to_not include 'test-join-as-dev'
    end

    it do
      team.tap do
        8.times { team.add_developer(sign_up) }
        _1.save!
      end

      get team_developers_path(team_id: team.id)
      expect(response.body).to_not include 'test-join-as-dev'
    end
  end

  describe 'create' do
    context 'precondition is satisfied' do
      it do
        post team_developers_path(team_id: team.id, format: :stream)

        get team_developers_path(team_id: team.id)
        expect(response.body).to include user.name
      end
    end
  end
end
