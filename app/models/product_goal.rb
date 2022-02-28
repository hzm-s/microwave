class ProductGoal < ApplicationRecord
  attribute :content, :long_sentence

  validates :content, presence: true, domain_object: true
end
