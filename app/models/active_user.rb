class ActiveUser < ApplicationRecord
  attribute :email, :email

  belongs_to :user
  has_many :accounts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, domain_object: true

  class << self
    def new_with_account(name:, email:, avatar_url:, account:)
      new(name: name, email: email, avatar_url: avatar_url) do |au|
        au.accounts << account
      end
    end
  end
end
