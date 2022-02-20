module ProductSupport
  def create_product(name: 'product', vision: 'vision', goals: %w(1st_goal), current_goal: 0)
    Product.create!(name: name, vision: vision)
      .tap { create_product_goals(_1, goals) }
  end

  def create_product_goals(product, goal_contents)
    goal_contents.each { product.goals.create!(content: _1) }
  end
end

RSpec.configure { |c| c.include ProductSupport }
