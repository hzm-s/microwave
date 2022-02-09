class Name < Struct.new(:value)
  def to_s
    value
  end
end
