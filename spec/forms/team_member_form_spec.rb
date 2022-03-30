require 'rails_helper'

describe TeamMemberForm do
  let(:valid) do
    {
      roles_attributes: {
        '0' => { 'role' => 'product_owner' },
        '1' => { 'role' => '' },
        '2' => { 'role' => 'scrum_master' },
      }
    }
  end

  it do
    expect(described_class.parameters).to eq [{ roles_attributes: [:role] }]
  end

  it do
    form = described_class.new(valid)
    expect(form).to be_valid
  end

  it do
    team = Team.new { _1.errors.add(:members) }
    form = described_class.new(valid)
    form.import_errors(team)
    expect(form.errors[:base]).to eq team.errors[:members]
  end
end
