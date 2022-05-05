require 'rails_helper'

describe DeveloperCollection do
  let(:team) { create_team }

  it do
    8.times { team.add_developer(sign_up) }

    expect(team).to be_valid
  end

  it do
    9.times { team.add_developer(sign_up) }

    aggregate_failures do
      expect(team).to_not be_valid
      expect(team.errors[:developers]).to include t_model_error(:team, :developers, :too_many)
    end
  end

  it do
    user = sign_up
    team.add_developer(user)
    team.add_developer(user)

    aggregate_failures do
      expect(team).to_not be_valid
      expect(team.errors[:developers]).to include t_model_error(:team, :developers, :already_joined)
    end
  end
end
