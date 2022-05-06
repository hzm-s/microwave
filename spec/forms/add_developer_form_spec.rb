require 'rails_helper'

describe AddDeveloperForm do
  let(:team) { create_team }
  let(:user) { sign_up }

  it do
    form = described_class.new(team: team, user: user)
    expect(form).to be_valid
  end

  it do
    create_team(name: 'other', dev: [user])

    form = described_class.new(team: team, user: user)

    aggregate_failures do
      expect(form).to_not be_valid
      expect(form.errors[:base]).to include t_model_error(:developer, :base, :already_joined)
    end
  end

  it do
    team.tap do
      8.times { add_developer(team, sign_up) }
    end

    form = described_class.new(team: team, user: user)

    aggregate_failures do
      expect(form).to_not be_valid
      expect(form.errors[:base]).to include t_model_attr_error(:team, :developers, :too_many)
    end
  end
end
