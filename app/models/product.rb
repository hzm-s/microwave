class Product < ApplicationRecord
  attribute :name, :name
  attribute :vision, :long_sentence

  has_many :goals, class_name: 'ProductGoal'

  validates :name, presence: true, domain_object: true
  validates :vision, presence: true, domain_object: true
end
