require 'rails_helper'

describe ComponentHelper do
  let(:helper) { Object.new.extend(described_class) }

  describe 'merge options with css class' do
    it do
      result = helper.dd_container_options(transition_options)
      aggregate_failures do
        expect(result[:data]).to eq({
          controller: 'dropdown',
          transition_enter_from: 'opacity-0 scale-95',
          transition_enter_to: 'opacity-100 scale-100',
          transition_leave_from: 'opacity-100 scale-100',
          transition_leave_to: 'opacity-0 scale-95',
        })
        expect(result[:class]).to eq 'relative inline-block transition'
      end
    end
  end

  describe 'dd_target_options' do
    it do
      result = helper.dd_target_options
      expect(result[:class]).to include 'origin-top-left left-0'
    end

    it do
      result = helper.dd_target_options(position: :right)
      expect(result[:class]).to include 'origin-top-right right-0'
    end
  end
end
