require 'rails_helper'

describe Team do
  describe 'add member' do
    let(:team) { described_class.create!(name: 'team') }
    let(:user) { sign_up }

    it do
      member = TeamMember.new(user: user, roles: team_member_roles(:po))
      team.add_member(member)

      aggregate_failures do
        expect(team.members.size).to eq 1
        expect(team.members[0].team).to eq team
        expect(team.members[0].user).to eq user
        expect(team.members[0].roles.map(&:role)).to eq %w(product_owner)
      end
    end
  end

  describe 'validation' do
    let(:valid) do
      {
        name: 'the team',
      }
    end

    it do
      expect(described_class.new(valid)).to be_valid
    end

    it do
      expect(described_class.new(valid.merge(name: ''))).to_not be_valid
      expect(described_class.new(valid.merge(name: 'a' * 51))).to_not be_valid
    end
  end
end
