require "multi_logger/version"

module MultiLogger
  class << self
    def add_logger(name, options={})
      name = name.to_s
      rails_logger_class = get_rails_logger_class()

      raise "'#{name}' is reserved in #{rails_logger_class} and can not be used as a log accessor name." if rails_logger_class.method_defined?(name)

      logger = Logger.new(*extract_options(name, options))
      rails_logger_class.class_eval do
        define_method name.to_sym do
          logger
        end
      end

      logger.formatter = options[:formatter] if options[:formatter]
    end

    private
    
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

    def extract_options(name, options)
      path = get_path(name, options[:path])

      if options[:shift_age] && options[:shift_size]
        [path, options[:shift_age], options[:shift_size]]
      elsif options[:shift_age]
        # options[:shift_age] => 'daily', 'weekly'
        [path, options[:shift_age]]
      else
        [path]
      end
    end
  end
end
