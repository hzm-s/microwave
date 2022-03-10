class BaseUsecase
  class << self
    def perform(*args, **kwargs, &block)
      new.perform(*args, **kwargs, &block)
    end
  end

  def succeeded(result = {})
    result.merge(succeeded?: true)
      .then { OpenStruct.new(_1) }
  end

  def failed(result = {})
    result.merge(succeeded?: false)
      .then { OpenStruct.new(_1) }
  end
end
