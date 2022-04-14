module ProductSupport
  def create_product(name: 'product', vision: 'vision', owner: nil)
    owner ||= sign_up
    Product.create!(owner: owner, name: name, vision: vision)
  end

  def create_product_goals(product, goal_contents)
    goal_contents.each { product.goals.create!(content: _1) }
  end
end

RSpec.configure { |c| c.include ProductSupport }
