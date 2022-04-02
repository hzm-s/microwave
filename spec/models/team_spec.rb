require 'rails_helper'

describe Team do
  describe 'add member' do
    let(:team) { described_class.create!(name: 'team') }
    let(:user) { sign_up }

    it do
      team.add_member(user: user, roles: team_member_roles(:po))

      aggregate_failures do
        expect(team.members.size).to eq 1
        expect(team.members[0].team).to eq team
        expect(team.members[0].user).to eq user
        expect(team.members[0].roles.map(&:role)).to eq %w(product_owner)
      end
    end

    it do
      team.add_member(user: user, roles: team_member_roles(:po))
      team.add_member(user: user, roles: team_member_roles(:po))
      expect(team).to_not be_valid
    end
  end

  describe 'query member' do
    let(:team) { described_class.create!(name: 'team') }
    let(:user1) { sign_up }
    let(:user2) { sign_up }

    it do
      team.add_member(user: user1, roles: team_member_roles(:dev))

      aggregate_failures do
        expect(team.member?(user1.id)).to be true
        expect(team.member?(user2.id)).to be false
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

    it do
      team = described_class.new(valid) do |t|
        t.add_member(user: sign_up, roles: team_member_roles(:po))
        t.add_member(user: sign_up, roles: team_member_roles(:sm, :po))
        t.add_member(user: sign_up, roles: team_member_roles(:sm, :dev))
        8.times { t.add_member(user: sign_up, roles: team_member_roles(:dev)) }
        t.validate
      end
      expect(team.errors[:members]).to match_array [
        t_model_error(:team, :members, :appropriate_number_of_role, role: 'プロダクトオーナー', number: 1),
        t_model_error(:team, :members, :appropriate_number_of_role, role: 'スクラムマスター', number: 1),
        t_model_error(:team, :members, :appropriate_number_of_role, role: '開発者', number: 8),
      ]
    end
  end
end
