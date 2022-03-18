class Team < ApplicationRecord
  has_many :members, class_name: 'TeamMember'

  attribute :name, :name

  validates :name, presence: true, domain_object: true

  def add_member(member)
    self.members << member
  end
end
