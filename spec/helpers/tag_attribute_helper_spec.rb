require 'rails_helper'

describe TagAttributeHelper do
  let(:helper) { Object.new.extend(described_class) }

  describe 'merge_tag_attrs' do
    it do
      default = {
        data: {
          data_1: :data_1_default,
          data_2: {
            data_2_1: :data_2_1_default,
            data_2_2: :data_2_2_default,
          },
        },
        class: 'default_class1 default_class2',
      }
      extra = {
        data: {
          extra_data_1: :extra_data_1,
          data_2_2: :override,
        },
        class: 'extra_class',
      }

      result = helper.merge_tag_attrs(default, extra)

      expect(result[:data]).to eq default[:data].deep_merge(extra[:data])
    end

    it do
      default = {
        data: {},
        class: 'default_class1 default_class2',
      }
      extra = {
        data: {},
        class: 'extra_class',
      }

      result = helper.merge_tag_attrs(default, extra)

      expect(result[:class]).to eq 'default_class1 default_class2 extra_class'
    end

    it do
      default = {
        data: {},
      }
      extra = {
        data: {},
        class: 'extra_class',
      }

      result = helper.merge_tag_attrs(default, extra)

      expect(result[:class]).to eq 'extra_class'
    end

    it do
      default = {
        data: {},
        class: 'default_class1 default_class2',
      }
      extra = {
        data: {},
      }

      result = helper.merge_tag_attrs(default, extra)

      expect(result[:class]).to eq 'default_class1 default_class2'
    end
  end
end
