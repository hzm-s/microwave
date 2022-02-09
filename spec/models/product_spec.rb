require 'rails_helper'

describe Product do
  it do
    name = Name.new('microwave')
    product = Product.create!(name: name.to_s, vision: 'vision')
    expect(Product.find_by(name: name).name).to eq name
  end
end
