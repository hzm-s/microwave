module Sentence
  class Long < Struct.new(:value)
    def to_s
      value
    end
  end
end
