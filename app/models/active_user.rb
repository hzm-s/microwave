class ActiveUser < ApplicationRecord
  attribute :email, :email

  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, domain_object: true

  class << self
    def new_with_account(name:, email:, account:)
      candidate = new(name: name, email: email) { _1.accounts << account }
      return candidate unless candidate.valid?

      candidate.tap { _1.initials = _1.email.initials }
    end
  end
end
