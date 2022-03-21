require 'rails_helper'

describe TeamMemberRolesAccessible do
  let(:form_class) do
    Class.new.tap do |c|
      c.include ActiveModel::Model
      c.include TeamMemberRolesAccessible
      c.validate :must_have_valid_roles
    end
  end

  it do
    expect(form_class.parameters).to eq({ roles_attributes: [:role] })
  end

  it do
    form = form_class.new

    aggregate_failures do
      expect(form.roles.map(&:role)).to eq [nil, nil, nil]
      expect(form.role_name_at(0)).to eq 'product_owner'
      expect(form.role_name_at(1)).to eq 'developer'
      expect(form.role_name_at(2)).to eq 'scrum_master'
    end
  end

  it do
    form = form_class.new
    form.roles_attributes = {
      '0' => { 'role' => 'product_owner' },
      '1' => { 'role' => '' },
      '2' => { 'role' => 'scrum_master' },
    }
    expect(form.roles.map(&:role)).to eq ['product_owner', nil, 'scrum_master']
  end

  it do
    form = form_class.new
    form.roles_attributes = {
      '0' => { 'role' => 'product_owner' },
      '1' => { 'role' => 'developer' },
      '2' => { 'role' => '' },
    }
    aggregate_failures do
      team_member = TeamMember.new(roles: form.selected_roles).tap(&:validate)
      expect(form.valid?).to be team_member.valid?
      expect(form.errors[:roles]).to eq team_member.errors[:roles]
    end
  end
end
