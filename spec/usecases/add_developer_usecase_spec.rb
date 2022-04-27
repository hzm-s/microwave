require 'rails_helper'

describe AddDeveloperUsecase do
  let(:user) { sign_up }
  let(:team) { create_team }

  context 'valid params' do
    it do
      result = described_class.perform(team: team, user: user)

      aggregate_failures do
        expect(result).to be_succeeded

        developer = Developer.find_by(team_id: team.id, user_id: user.id)
        expect(developer).to_not be_nil
      end
    end
  end

  context 'NOT satisfy precondition' do
    it do
      team.tap do
        8.times { team.add_developer(sign_up) }
        _1.save
      end

      result = described_class.perform(team: team, user: user)

      aggregate_failures do
        expect(result).to_not be_succeeded
        expect(result.team.errors[:developers]).to include t_model_error(:team, :developers, :too_many)
        expect(team.reload.developers.count).to eq 8
      end
    end
  end
end
