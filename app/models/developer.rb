class Developer < ApplicationRecord
  belongs_to :team
  belongs_to :user

  delegate :name, :avatar_url, to: :user
end
