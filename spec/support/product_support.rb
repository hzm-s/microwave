module ProductSupport
  def register_product(name: 'product', vision: 'vision')
    Product.create!(name: name, vision: vision)
  end

  def add_product_goals(product, goal_contents)
    goal_contents.each { product.goals.create!(content: _1) }
  end
end

RSpec.configure { |c| c.include ProductSupport }
