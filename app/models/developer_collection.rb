module DeveloperCollection
  def validate
    if size > 8
      proxy_association.owner.errors.add(:developers, :too_many)
    end

    if size != map(&:user).uniq.size
      proxy_association.owner.errors.add(:developers, :already_joined)
    end
  end
end
