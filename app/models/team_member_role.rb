class TeamMemberRole < ApplicationRecord
  belongs_to :team_member

  enum :role, { product_owner: 0, developer: 1, scrum_master: 2 }

  class << self
    def role_names
      roles.keys.map(&:to_sym)
    end

    def i18n_scope_for_roles
      [i18n_scope, :enums, :team_member_roles, :roles]
    end
  end
end
