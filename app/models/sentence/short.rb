module Sentence
  class Short < Struct.new(:value)
    def to_s
      value
    end
  end
end
