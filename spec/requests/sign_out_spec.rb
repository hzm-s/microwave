require 'rails_helper'

describe '/sign_out' do
  let(:user) { sign_up }

  context 'when signed in' do
    before do
      sign_in(user)
    end

    it do
      delete sign_out_path
      expect(response).to redirect_to sign_in_path
    end

    it do
      expect_any_instance_of(SessionsController).to receive(:reset_session)
      delete sign_out_path
    end
  end

  context 'when NOT signed in' do
    it do
      delete sign_out_path
      expect(response).to redirect_to sign_in_path
    end

    it do
      expect_any_instance_of(SessionsController).to_not receive(:reset_session)
      delete sign_out_path
    end
  end
end
