class NameType < ActiveRecord::Type::String
  def cast(value)
    if value.is_a?(Name)
      super(value.to_s)
    else
      Name.new(value)
    end
  end

  def serialize(obj)
    obj.to_s
  end
end
