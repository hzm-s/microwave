class Email < Struct.new(:value)
  def initialize(value)
    local, domain = *value.split('@')

    raise ArgumentError, 'invalid_email' unless domain

    super
  end

  alias_method :to_s, :value
end
