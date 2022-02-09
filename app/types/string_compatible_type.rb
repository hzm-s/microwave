class StringCompatibleType
  class << self
    def [](class_name)
      new(class_name).generate_type_class
    end
  end

  def initialize(class_name)
    @class_name = class_name
  end

  def generate_type_class
    Class.new(ActiveRecord::Type::String).tap { |c| define_cast_methods(c) }
  end

  def define_cast_methods(klass)
    klass.class_eval <<-CODE, __FILE__, __LINE__ + 1
      def cast(value)
        if value.is_a?(#{@class_name})
          super(value.to_s)
        else
          #{@class_name}.new(value)
        end
      end

      def serialize(obj)
        obj.to_s
      end
    CODE
  end
end
