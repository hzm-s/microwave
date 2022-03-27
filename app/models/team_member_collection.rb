module TeamMemberCollection
  def has_appropriate_number_of_role?(role_name, number)
    by_role(role_name).size <= number
  end

  def include_user?(user_id)
    any? { _1.user_id == user_id }
  end

  def by_role(role_name)
    select { _1.have_role?(role_name) }
  end
end
