class Team < ApplicationRecord
  has_many :developers, ->{ extending DeveloperCollection }, dependent: :destroy

  attribute :name, :name

  validates :name, presence: true, domain_object: true
  validate { developers.validate }

  def add_developer(user)
    self.developers.build(user: user)
  end

  def developer?(user_id)
    developers.exists?(user_id: user_id)
  end
end
