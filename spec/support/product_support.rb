module ProductSupport
  def create_product(name: 'product', vision: 'vision', goals: %w(1st_goal), current_goal: 0)
    Product.create!(name: name, vision: vision)
      .tap { add_product_goals(_1, goals) }
      .tap { set_current_product_goal(_1, current_goal) }
  end

  def add_product_goals(product, goal_contents)
    goal_contents.each { product.goals.create!(content: _1) }
  end

  def set_current_product_goal(product, goal_index)
    return unless goal_index

    product.backlog.set_goal(product.goals[goal_index].id)
  end
end

RSpec.configure { |c| c.include ProductSupport }
