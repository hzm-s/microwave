class CancelledUser < ApplicationRecord
  before_create do
    self.cancelled_at = Time.current
  end

  def name
    'cancelled_user'
  end

  def email
    nil
  end

  def accounts
    []
  end
end
