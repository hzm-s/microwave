class Product < ApplicationRecord
  attribute :name, :name
  attribute :vision, :long_sentence

  has_one :backlog, class_name: 'ProductBacklog'

  validates :name, presence: true, domain_object: true
  validates :vision, presence: true, domain_object: true

  before_create do
    self.build_backlog
  end
end
