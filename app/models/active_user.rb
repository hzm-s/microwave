class ActiveUser < ApplicationRecord
  attribute :email, :email

  belongs_to :user
  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, domain_object: true

  class << self
    def new_with_account(name:, email:, account:)
      candidate = new(name: name, email: email) { _1.accounts << account }
      candidate.validate
      candidate.errors.delete(:user)
      return candidate if candidate.errors.any?

      candidate.tap { _1.initials = _1.email.initials }
    end
  end
end
