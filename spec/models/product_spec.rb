require 'rails_helper'

describe Product do
  let(:name) { 'product name' }
  let(:vision) { 'product vision' }

  let(:product) { described_class.create!(name: name, vision: vision) }
end
