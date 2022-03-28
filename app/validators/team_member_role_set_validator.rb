class TeamMemberRoleSetValidator < ActiveModel::EachValidator
  def validate_each(model, attr, value)
    model.errors.add(attr, :empty) if value.empty?
    model.errors.add(attr, :less_than_three) if too_many_roles?(value)
    model.errors.add(attr, :duplicated) if duplicated?(value)
    model.errors.add(attr, :can_not_be_po_and_dev) if po_and_dev?(value)
  end

  private

  def too_many_roles?(value)
    value.size > 2
  end

  def duplicated?(value)
    value.size != value.map(&:role).uniq.size
  end

  def po_and_dev?(value)
    value.map(&:role).to_set == Set['product_owner', 'developer']
  end
end
