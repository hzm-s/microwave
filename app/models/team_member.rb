class TeamMember < ApplicationRecord
  belongs_to :team
  belongs_to :user
  has_many :roles, class_name: 'TeamMemberRole' do
    def include_role?(role_name)
      any? { _1.role == role_name.to_s }
    end
  end

  validates :roles, team_member_role_set: true

  delegate :name, :initials, to: :user

  def have_role?(role_name)
    roles.include_role?(role_name)
  end
end
