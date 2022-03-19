require 'rails_helper'

describe '/teams' do
  let(:user) { sign_up }

  before { sign_in(user) }

  describe 'POST' do
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
end
