require 'rails_helper'

describe '/team/:team_id/members' do
  let(:user) { sign_up }
  let(:team) { create_team }

  before { sign_in(user) }

  describe 'new' do
    it do
      add_team_member(team, user, :po)

      get new_team_member_path(team_id: team.id)

      aggregate_failures do
        expect(response.body).to include t_model_error(:team, :members, :already_added)
      end
    end
  end

  describe 'create' do
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

      it do
        team.tap do
          _1.add_member(user: sign_up, roles: team_member_roles(:sm))
          _1.save!
        end
        post team_members_path(team_id: team.id), params: { form: valid }
        expect(response.body).to include t_model_error(:team, :members, :appropriate_number_of_role, role: 'スクラムマスター', number: 1)
      end
    end
  end
end
