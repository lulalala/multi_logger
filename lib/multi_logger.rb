require "multi_logger/version"

module MultiLogger
  class << self
    def add_logger(name, path=nil)
      name = name.to_s

      logger = Logger.new(get_path(name, path))

      rails_logger_class = get_rails_logger_class()
      if rails_logger_class.method_defined?(name)
        raise "'#{name}' is reserved in #{rails_logger_class} and can not be used as a log name."
      else
        rails_logger_class.class_eval do
          define_method name.to_sym do
            logger
          end
        end
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
      end
    end
  end
end
