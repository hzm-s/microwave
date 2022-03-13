class Team < ApplicationRecord
  attribute :name, :name

  validates :name, presence: true, domain_object: true
end
