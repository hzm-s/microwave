class DevelopmentTeam < ApplicationRecord
  belongs_to :product
  belongs_to :team
end
