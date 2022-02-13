class Product < ApplicationRecord
  attribute :name, :name
  attribute :vision, :long_sentence

  has_one :backlog, class_name: 'ProductBacklog', dependent: :destroy
  has_many :goals, class_name: 'ProductGoal', dependent: :destroy

  before_create do
    self.build_backlog
  end
end
