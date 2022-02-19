module ProductSupport
  def create_product(name: 'product', vision: 'vision', goals: %w(1st_goal), current_goal: 0)
    Product.create!(name: name, vision: vision)
  end
end

RSpec.configure { |c| c.include ProductSupport }
