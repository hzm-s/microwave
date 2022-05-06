require 'rails_helper'

describe Developer do
  describe 'validation' do
    it do
      user = sign_up
      create_team(name: 'other team', dev: [user])

      team = create_team
      dev = described_class.new(user: user, team: team)

      aggregate_failures do
        expect(dev).to_not be_valid
        expect(dev.errors[:base]).to include t_model_error(:developer, :base, :already_joined)
      end
    end
  end
end
