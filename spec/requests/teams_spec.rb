require 'rails_helper'

describe '/teams' do
  describe 'create' do
    let(:user) { sign_up }

    before { sign_in(user) }

    let(:valid) do
      {
        name: 'THE_RIGHT_TEAM',
        roles_attributes: {
          '0' => { role: 'product_owner' },
          '1' => { role: '' },
          '2' => { role: '' },
        }
      }
    end

    context 'given valid params' do
      it do
        post teams_path, params: { form: valid }

        get teams_path
        expect(response.body).to include valid[:name]
      end
    end

    context 'given invalid params' do
      it do
        post teams_path, params: { form: valid.merge(name: '') }
        expect(response.body).to include I18n.t('errors.messages.blank')
      end
    end
  end

  describe 'show' do
    it do
      po = sign_up
      dev = sign_up
      sm = sign_up
      team = create_team(name: 'A_TEAM', po: po, dev: [dev], sm: sm)

      get team_path(team.id)

      aggregate_failures do
        expect(response.body).to include team.name.to_s
        expect(response.body).to include po.name
        expect(response.body).to include dev.name
        expect(response.body).to include sm.name
      end
    end
  end
end
