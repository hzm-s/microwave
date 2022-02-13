class Work < ApplicationRecord
  attribute :description, :long_sentence

  enum :status, { preparation: 0 }

  belongs_to :product

  before_create do
    self.number = self.class.max_number_of_product(product_id) + 1
    self.status = :preparation
  end

  class << self
    def max_number_of_product(product_id)
      where(product_id: product_id).maximum(:number).to_i
    end
  end
end
