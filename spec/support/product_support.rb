module ProductSupport
  DEFAULT_ATTRS = {
    product: {
      name: 'product A',
      vision: 'product vision',
      goal: 'first goal of product',
    },
  }

  def create_product(attrs = DEFAULT_ATTRS[:product])
    attrs.slice(:name, :vision)
      .then { Product.create!(_1) }
      .tap { _1.set_goal(attrs[:goal]) if attrs[:goal] }
  end
end

RSpec.configure { |c| c.include ProductSupport }
