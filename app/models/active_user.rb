class ActiveUser < ApplicationRecord
  attribute :email, :email

  has_many :accounts, dependent: :destroy

  class << self
    def new_with_account(name:, email:, account:)
      new(name: name, email: email) do |active_user|
        active_user.initials = active_user.email.initials
        active_user.accounts << account
      end
    end
  end
end
