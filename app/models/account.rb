class Account < ApplicationRecord
  validates :provider, presence: true
  validates :uid, presence: true
end
