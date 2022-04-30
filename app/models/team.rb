class Team < ApplicationRecord
  has_many :developers, dependent: :destroy

  attribute :name, :name

  validates :name, presence: true, domain_object: true
  validate :appropriate_number_of_developers

  def add_developer(user)
    self.developers.build(user: user)
  end

  def developer?(user_id)
    developers.exists?(user_id: user_id)
  end

  private

  def appropriate_number_of_developers
    if developers.size > 8
      errors.add(:developers, :too_many)
    end
  end
end
