require 'rails_helper'

describe RegisterTeamWithMemberUsecase do
  let(:user) { sign_up }

  context 'valid params' do
    it do
      roles = team_member_roles(:po, :sm)
      result = described_class.perform(name: 'the team', user: user, roles: roles)

      aggregate_failures do
        expect(result).to be_succeeded

        team = Team.find(result.team.id)
        expect(team.name.to_s).to eq 'the team'

        members = team.members.map { { user_id: _1.user_id, roles: _1.roles.map(&:role) } }
        expect(members).to eq [{ user_id: user.id, roles: %w(product_owner scrum_master) }]
      end
    end
  end

  context 'invalid params' do
    it do
      roles = team_member_roles(:po, :dev)
      result = described_class.perform(name: 'the team', user: user, roles: roles)

      aggregate_failures do
        expect(result).to_not be_succeeded
        expect(Team.count).to eq 0
        expect(TeamMember.count).to eq 0
        expect(TeamMemberRole.count).to eq 0
      end
    end
  end
end
