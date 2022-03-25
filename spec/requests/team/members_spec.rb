require 'rails_helper'

describe '/team/:team_id/members' do
  let(:user) { sign_up }
  let(:team) { create_team }

  before { sign_in(user) }

  describe 'POST' do
    let(:valid) do
      {
        roles_attributes: {
          '0' => { role: 'product_owner' },
          '1' => { role: '' },
          '2' => { role: 'scrum_master' },
        }
      }
    end

    context 'given valid params' do
      it do
        post team_members_path(team_id: team.id), params: { form: valid }
        team_member = TeamMember.find_by(user_id: user.id, team_id: team.id)
        expect(team_member.roles.map(&:role)).to match_array %w(product_owner scrum_master)
      end
    end

    context 'given invalid params' do
      it do
        params = {
          form: valid.deep_merge(
            roles_attributes: { '1' => { role: 'developer' } }
          )
        }
        post team_members_path(team_id: team.id), params: params
        expect(response.body).to include I18n.t('activerecord.errors.models.team_member.attributes.roles.less_than_three')
      end
    end
  end
end
