require 'rails_helper'

describe '/team/:team_id/developers' do
  let(:user) { sign_up }
  let(:team) { create_team }

  before { sign_in(user) }

  describe 'new' do
    it do
      add_developer(team, user)

      get new_team_developer_path(team_id: team.id)

      aggregate_failures do
        expect(response.body).to include t_model_error(:team, :developers, :already_joined)
      end
    end
  end

  describe 'create' do
    context 'precondition is satisfied' do
      it do
        post team_developers_path(team_id: team.id)

        get team_path(team.id)
        expect(response.body).to include user.name
      end
    end

    context 'precondition is NOT satisfied' do
      it do
        team.tap do
          8.times { team.add_developer(sign_up) }
          _1.save!
        end

        post team_developers_path(team_id: team.id)
        expect(response.body).to include t_model_error(:team, :developers, :too_many)
      end
    end
  end
end
