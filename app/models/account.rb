class Account < ApplicationRecord
  belongs_to :active_user

  validates :provider, presence: true
  validates :uid, presence: true

  delegate :user, to: :active_user
end
