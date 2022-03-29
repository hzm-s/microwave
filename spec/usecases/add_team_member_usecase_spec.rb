require 'rails_helper'

describe AddTeamMemberUsecase do
  let(:user) { sign_up }
  let(:team) { create_team }

  context 'valid params' do
    it do
      roles = team_member_roles(:po, :sm)
      result = described_class.perform(team: team, user: user, roles: roles)

      aggregate_failures do
        expect(result).to be_succeeded

        member = TeamMember.find_by(team_id: team.id, user_id: user.id)
        expect(member.roles.map(&:role)).to match_array %w(product_owner scrum_master)
      end
    end
  end

  context 'invalid params' do
    it do
      team.tap do
        _1.add_member(user: sign_up, roles: team_member_roles(:po))
        _1.save
      end
      roles = team_member_roles(:po, :dev)
      result = described_class.perform(team: team, user: user, roles: roles)

      aggregate_failures do
        expect(result).to_not be_succeeded
        expect(result.team.errors[:members]).to include t_model_error(:team, :members, :appropriate_number_of_role, role: 'プロダクトオーナー', number: 1)
        expect(TeamMember.count).to eq 1
        expect(TeamMemberRole.count).to eq 1
      end
    end
  end
end
