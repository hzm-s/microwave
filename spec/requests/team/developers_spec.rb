require 'rails_helper'

describe '/team/:team_id/developers' do
  let(:user) { sign_up }
  let(:team) { create_team }

  before { sign_in(user) }

  xdescribe 'new' do
    it do
      add_team_member(team, user, :po)

      get new_team_member_path(team_id: team.id)

      aggregate_failures do
        expect(response.body).to include t_model_error(:team, :members, :already_added)
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
