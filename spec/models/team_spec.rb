require 'rails_helper'

describe Team do
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
        9.times { t.add_developer(sign_up) }
        t.validate
      end
      expect(team.errors[:developers]).to include t_model_error(:team, :members, :appropriate_number_of_role, role: '開発者', number: 8)
    end
  end
end
