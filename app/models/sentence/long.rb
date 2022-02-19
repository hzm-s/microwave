module Sentence
  class Long < Struct.new(:value)
    def initialize(value)
      raise ArgumentError, 'length' unless (3..1000).include?(value.to_s.size)

      super
    end

    def to_s
      value
    end
  end
end
