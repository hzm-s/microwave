module TeamMemberCollection
  def has_appropriate_number_of_product_owner?
    by_role(:product_owner).size <= 1
  end

  def has_appropriate_number_of_scrum_master?
    by_role(:scrum_master).size <= 1
  end

  def has_appropriate_number_of_developers?
    by_role(:developer).size <= 8
  end

  def include_user?(user_id)
    any? { _1.user_id == user_id }
  end

  def compliant_with_scrum_team?
    return false if by_role('product_owner').size > 1

    true
  end

  def by_role(role_name)
    select { _1.have_role?(role_name) }
  end
end
