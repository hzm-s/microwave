require 'rails_helper'

describe TeamMember do
  describe 'validation' do
    let(:team) { create_team }
    let(:user) { sign_up }

    let(:valid) do
      {
        team_id: team.id,
        user_id: user.id,
        roles: team_member_roles(:dev),
      }
    end

    it do
      expect(described_class.new(valid)).to be_valid
    end

    it do
      aggregate_failures do
        expect(described_class.new(valid.merge(roles: []))).to_not be_valid
        expect(described_class.new(valid.merge(roles: team_member_roles(:dev, :dev)))).to_not be_valid
        expect(described_class.new(valid.merge(roles: team_member_roles(:po, :dev)))).to_not be_valid
        expect(described_class.new(valid.merge(roles: team_member_roles(:po, :dev, :sm)))).to_not be_valid
      end
    end
  end
end
