class BaseUsecase
  class << self
    def perform(*args, **kwargs, &block)
      new.perform(*args, **kwargs, &block)
    end
  end

  def success(payload)
    payload.merge(succeeded?: true)
      .then { OpenStruct.new(_1) }
  end

  def fail
    payload.merge(succeeded?: false)
      .then { OpenStruct.new(_1) }
  end
end
