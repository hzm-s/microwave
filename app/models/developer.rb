class Developer < ApplicationRecord
  belongs_to :team
  belongs_to :user

  delegate :name, :avatar_url, to: :user

  validate do
    if user.developer?
      errors.add(:base, :already_joined)
    end
  end
end
