module DeveloperCollection
  MAX_NUM_OF_USER = 8

  def can_join_as_developer?(user)
    return false if user.developer?

    size <= MAX_NUM_OF_USER - 1
  end

  def validate
    if size > MAX_NUM_OF_USER
      proxy_association.owner.errors.add(:developers, :too_many)
    end

    if size != map(&:user).uniq.size
      proxy_association.owner.errors.add(:developers, :already_joined)
    end
  end
end
