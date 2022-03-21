class RegisterTeamForm
  include ActiveModel::Model
  include TeamMemberRolesAccessible

  attr_accessor :name

  validates :name, presence: true
  validate :must_have_valid_roles

  class << self
    def parameters
      [:name, team_member_roles_parameters]
    end
  end
end
