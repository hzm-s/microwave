module ProductSupport
  def register_product(name: 'product', vision: 'vision', owner: nil)
    Product.create!(name: name, vision: vision).tap do |p|
      owner && ProductOwner.create!(product: p, user: owner)
    end
  end

  def add_product_goals(product, goal_contents)
    goal_contents.each { product.goals.create!(content: _1) }
  end
end

RSpec.configure { |c| c.include ProductSupport }
