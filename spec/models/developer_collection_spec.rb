require 'rails_helper'

describe DeveloperCollection do
  let(:team) { create_team }
  let(:user) { sign_up }

  context 'num of dev = 7' do
    before do
      7.times { team.add_developer(sign_up) }
    end

    it do
      team.add_developer(user)
      expect(team).to be_valid
    end

    it do
      expect(team.can_join_as_developer?(user)).to be true
    end
  end

  context 'num of dev = 8' do
    before do
      8.times { team.add_developer(sign_up) }
    end

    it do
      team.add_developer(user)
      aggregate_failures do
        expect(team).to_not be_valid
        expect(team.errors[:developers]).to include t_model_error(:team, :developers, :too_many)
      end
    end

    it do
      expect(team.can_join_as_developer?(user)).to be false
    end
  end

  context 'already joined to other team' do
    before do
      create_team(name: 'other', dev: [user])
    end

    it do
      expect(team.can_join_as_developer?(user)).to be false
    end
  end

  context 'already joined' do
    before do
      add_developer(team, user)
    end

    it do
      expect(team.can_join_as_developer?(user)).to be false
    end

    it do
      team.add_developer(user)

      aggregate_failures do
        expect(team).to_not be_valid
        expect(team.errors[:developers]).to include t_model_error(:team, :developers, :already_joined)
      end
    end
  end
end
