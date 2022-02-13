class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def rollback!
    raise ActiveRecord::Rollback
  end
end
