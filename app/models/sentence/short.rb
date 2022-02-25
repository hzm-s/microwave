module Sentence
  class Short < Struct.new(:value)
    def initialize(value)
      raise ArgumentError, 'invalid_short_sentence' unless (2..500).include?(value.to_s.size)

      super
    end

    def to_s
      value
    end
  end
end
