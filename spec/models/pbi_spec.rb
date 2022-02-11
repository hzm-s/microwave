require 'rails_helper'

describe Pbi do
  let(:product) { create_product }

  describe '.create_for_goal' do
    it do
      described_class.create_for_goal
    end
  end
end
