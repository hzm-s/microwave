class ScrumTeamMembersValidator < ActiveModel::EachValidator
  APPROPRIATE_NUMBER_OF_ROLES = {
    product_owner: 1,
    scrum_master: 1,
    developer: 8,
  }

  def validate_each(model, attr, value)
    TeamMemberRole.role_names.each do |role_name|
      appropriate_number = APPROPRIATE_NUMBER_OF_ROLES[role_name]
      unless value.has_appropriate_number_of_role?(role_name, appropriate_number)
        message_for_appropriate_number_of_role(role_name, appropriate_number)
          .then { |key, options| model.errors.add(attr, key, **options) }
      end
    end
  end

  private

  def message_for_appropriate_number_of_role(role_name, appropriate_number)
    [:appropriate_number_of_role, role: I18n.t(role_name, scope: TeamMemberRole.i18n_scope_for_roles), number: appropriate_number]
  end
end
