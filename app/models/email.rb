class Email < Struct.new(:value)
  def initialize(value)
    @local, domain = *value.split('@')

    raise ArgumentError, 'invalid_email' unless domain

    super
  end

  def initials
    first, last = *@local.split('.', 2)

    return first.slice(0, 2) unless last

    "#{first.slice(0)}#{last.slice(0)}"
  end

  alias_method :to_s, :value
end
