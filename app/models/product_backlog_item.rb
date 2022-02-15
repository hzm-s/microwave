class ProductBacklogItem < ApplicationRecord
  belongs_to :work

  delegate :product_id, :number, :status, :description, :size, to: :work
end
