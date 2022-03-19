class ActiveUser < ApplicationRecord
  attribute :email, :email

  belongs_to :user
  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, domain_object: true

  class << self
    def new_with_account(name:, email:, account:)
      new(name: name, email: email) do |au|
        au.accounts << account
        au.initials = au.email&.initials
      end
    end
  end
end
