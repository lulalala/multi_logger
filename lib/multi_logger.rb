require "multi_logger/version"

module MultiLogger
  class << self
    def add_logger(name, path=nil)
      name = name.to_s
      if path.nil?
        path = name.underscore
      end
      if !path.include?('/')
        path = Rails.root.join('log',path).to_s
      end
      if !path.end_with?('.log')
        path += '.log'
      end

      logger = Logger.new(path)

      if self.respond_to? name
        raise "'#{name}' is reserved and can not be used as a log name."
      end

      (class << self; self; end).instance_eval do
        define_method name.to_sym do
          logger
        end
      end
    end
  end
end

module Rails
  class << self
    def loggers
      MultiLogger
    end
  end
end
