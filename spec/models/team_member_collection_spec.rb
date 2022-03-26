require 'rails_helper'

describe TeamMemberCollection do
  let(:user_a) { sign_up }
  let(:user_b) { sign_up }

  describe 'product owner' do
    it do
      aggregate_failures do
        expect(build_members([])).to have_appropriate_number_of_product_owner
        expect(build_members([team_member(user_a, :po)])).to have_appropriate_number_of_product_owner
        expect(build_members([team_member(user_a, :po, :sm)])).to have_appropriate_number_of_product_owner
        expect(build_members([
          team_member(user_a, :po),
          team_member(user_b, :po),
        ])).to_not have_appropriate_number_of_product_owner
        expect(build_members([
          team_member(user_a, :po),
          team_member(user_b, :sm, :po),
        ])).to_not have_appropriate_number_of_product_owner
      end
    end
  end

  describe 'scrum master' do
    it do
      aggregate_failures do
        expect(build_members([])).to have_appropriate_number_of_scrum_master
        expect(build_members([team_member(user_a, :sm)])).to have_appropriate_number_of_scrum_master
        expect(build_members([team_member(user_a, :sm, :dev)])).to have_appropriate_number_of_scrum_master
        expect(build_members([
          team_member(user_a, :sm),
          team_member(user_b, :sm),
        ])).to_not have_appropriate_number_of_scrum_master
        expect(build_members([
          team_member(user_a, :sm),
          team_member(user_b, :po, :sm),
        ])).to_not have_appropriate_number_of_scrum_master
      end
    end
  end

  describe 'developer' do
    let(:user_c) { sign_up }
    let(:user_d) { sign_up }
    let(:user_e) { sign_up }
    let(:user_f) { sign_up }
    let(:user_g) { sign_up }
    let(:user_h) { sign_up }
    let(:user_i) { sign_up }
    let(:user_j) { sign_up }
    let(:user_k) { sign_up }

    it do
      aggregate_failures do
        expect(build_members([])).to have_appropriate_number_of_developers
        expect(build_members([team_member(user_a, :dev)])).to have_appropriate_number_of_developers
        expect(build_members([team_member(user_a, :dev, :sm)])).to have_appropriate_number_of_developers
        expect(build_members([
          team_member(user_a, :po),
          team_member(user_b, :sm),
          team_member(user_c, :dev),
          team_member(user_d, :dev),
          team_member(user_e, :dev),
          team_member(user_f, :dev),
          team_member(user_g, :dev),
          team_member(user_h, :dev),
          team_member(user_i, :dev),
          team_member(user_j, :dev),
        ])).to have_appropriate_number_of_developers
        expect(build_members([
          team_member(user_a, :po),
          team_member(user_b, :sm),
          team_member(user_c, :dev),
          team_member(user_d, :dev),
          team_member(user_e, :dev),
          team_member(user_f, :dev),
          team_member(user_g, :dev),
          team_member(user_h, :dev),
          team_member(user_i, :dev),
          team_member(user_j, :dev),
          team_member(user_k, :dev),
        ])).to_not have_appropriate_number_of_developers
      end
    end
  end

  private

  def build_members(members)
    members.extend(described_class)
  end
end
