class ProductGoal < ApplicationRecord
  class AlreadyAchieved < StandardError; end

  attribute :content, :long_sentence

  enum :status, unachieved: 0, achieved: 1, default: :unachieved

  validates :content, presence: true, domain_object: true

  has_one :unachieved, class_name: 'UnachievedProductGoal', autosave: true
  has_one :achieved, class_name: 'AchievedProductGoal', autosave: true

  scope :unachieved, -> { joins(:unachieved) }

  before_create do
    self.status = :unachieved
    update_status_detail
  end

  before_update :update_status_detail

  def achieve!
    raise AlreadyAchieved if achieved?

    self.tap { achieved! }
  end

  private

  def update_status_detail
    return if persisted? && !status_changed?

    if unachieved?
      self.achieved&.mark_for_destruction
      self.unachieved || self.build_unachieved
    else
      self.unachieved&.mark_for_destruction
      self.achieved || self.build_achieved(achieved_at: Time.current)
    end
  end
end
