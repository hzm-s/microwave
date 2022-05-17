require 'rails_helper'

describe ScrumMaster do
  let(:user) { sign_up }
  let(:team_a) { create_team }
  let(:team_b) { create_team }

  describe 'validation' do
    it do
      sm = described_class.new(user: user)
      sm.add_team(team_a)
      sm.add_team(team_a)

      aggregate_failures do
        expect(sm).to_not be_valid
        expect(sm.errors[:base]).to include t_model_error(:scrum_master, :base, :duplicated_team)
      end
    end
  end

  describe 'query to lead' do
    let(:sm) { described_class.new(user: user) }

    it do
      expect(sm).to be_can_lead(team_a)
    end

    it do
      sm.add_team(team_a)
      sm.save!

      aggregate_failures do
        expect(sm).to_not be_can_lead(team_a)
        expect(sm).to be_can_lead(team_b)
      end
    end
  end
end
