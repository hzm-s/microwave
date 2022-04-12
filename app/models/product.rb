class Product < ApplicationRecord
  attribute :name, :name
  attribute :vision, :long_sentence

  belongs_to :owner, class_name: 'User'
  has_many :goals, class_name: 'ProductGoal'
  has_many :development_teams
  has_many :teams, through: :development_teams

  validates :name, presence: true, domain_object: true
  validates :vision, presence: true, domain_object: true
end
