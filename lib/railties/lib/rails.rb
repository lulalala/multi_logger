module Rails
  class << self
    def loggers
      MultiLogger
    end
  end
end
