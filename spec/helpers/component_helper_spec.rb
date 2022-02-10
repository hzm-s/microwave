require 'rails_helper'

describe ComponentHelper do
  let(:helper) { Object.new.extend(described_class) }

  describe '#component_attrs' do
    it do
      attrs = component_attrs(:rv_container, { data: { extra_key: :extra_value }, class: 'extra_class' })
      expect(attrs).to eq(
        {
          data: {
            controller: 'reveal',
            extra_key: :extra_value,
            reveal_hidden_class: 'hidden',
          },
          class: 'extra_class',
        }
      )
    end
  end
end
