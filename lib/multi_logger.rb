require "multi_logger/version"

module MultiLogger
  class << self
    def add_logger(name, options={})
      name = name.to_s
      rails_logger_class = get_rails_logger_class()

      if rails_logger_class.method_defined?(name)
        raise "'#{name}' is reserved in #{rails_logger_class} and can not be used as a log accessor name."
      else
        logger = Logger.new(get_path(name, options[:path]))
        rails_logger_class.class_eval do
          define_method name.to_sym do
            logger
          end
        end
        if options[:formatter]
          logger.formatter = options[:formatter]
        end
        logger
      end
    end

    # Computes log file path
    def get_path(name, path=nil)
      if path.nil?
        path = name.underscore
      end
      if !path.include?('/')
        path = Rails.root.join('log',path).to_s
      end
      if !path.end_with?('.log')
        path += '.log'
      end
    end

    def get_rails_logger_class
      if defined?(ActiveSupport::BufferedLogger)
        ActiveSupport::BufferedLogger
      elsif defined?(ActiveSupport::Logger)
        ActiveSupport::Logger
      else
        raise 'Rails logger not found'
      end
    end
  end
end
