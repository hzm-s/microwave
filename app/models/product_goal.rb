class ProductGoal < ApplicationRecord
  class CurrentGoalIsEnable < StandardError; end

  attribute :content, :long_sentence

  has_many :works, dependent: :destroy

  before_create do
    self.achieved = false
  end

  def achieve
    update!(achieved: true)
  end

  def add_work(description)
    self.works.create(product_id: product_id, description: description)
  end

  def enable?
    achieved == false
  end
end
