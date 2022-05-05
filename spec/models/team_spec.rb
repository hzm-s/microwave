require 'rails_helper'

describe Team do
  describe 'validation' do
    let(:valid) do
      {
        name: 'the team',
      }
    end

    it do
      expect(described_class.new(valid.merge(name: ''))).to_not be_valid
    end

    it do
      user = sign_up
      team = described_class.new(valid)
      team.add_developer(user)
      team.add_developer(user)

      expect(team).to_not be_valid
    end
  end
end
