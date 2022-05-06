class AddDeveloperForm
  include ActiveModel::Model

  attr_accessor :team, :user

  validate :valid_developer
  validate :valid_team, if: -> { _1.errors.empty? }

  def import_errors(model)
    model.errors.full_messages.each { errors.add(:base, _1) }
  end

  private

  def valid_developer
    developer = Developer.new(team: team, user: user)
    unless developer.valid?
      import_errors(developer)
    end
  end

  def valid_team
    team.add_developer(user)
    unless team.valid?
      import_errors(team)
    end
  end
end
