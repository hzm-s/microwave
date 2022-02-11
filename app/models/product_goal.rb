class ProductGoal < ApplicationRecord
  attribute :content, :short_sentence

  belongs_to :product, touch: true
end
