class ProductGoal < ApplicationRecord
  attribute :content, :long_sentence

  enum :status, unachieved: 0, achieved: 1, default: :unachieved

  validates :content, presence: true, domain_object: true

  has_one :unachieved, class_name: 'UnachievedProductGoal'
  has_one :achieved, class_name: 'AchievedProductGoal'

  before_create do
    self.status = 'unachieved'
    self.build_unachieved
  end
end
