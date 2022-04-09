require 'rails_helper'

describe '/team/development_teams' do
  let(:user) { sign_up }
  let!(:team) { create_team(name: 'KAIHATSU_TEAM', po: user) }
  let(:product) { create_product }

  describe 'create' do
    before { sign_in(user) }

    it do
      post product_development_teams_path(product_id: product.id)

      get product_path(product)

      aggregate_failures do
        expect(response.body).to include team.name.to_s
        expect(response.body).to_not include 'test-new-development-team'
      end
    end
  end
end
