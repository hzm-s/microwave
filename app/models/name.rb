class Name < Struct.new(:value)
  def initialize(value)
    raise ArgumentError, 'invalid_name' unless (1..50).include?(value.to_s.size)

    super
  end

  def to_s
    value
  end
end
