# MultiLogger

Makes it easier to create multiple log files in Rails.

## Installation

Add this line to your Rails application's Gemfile:

    gem 'multi_logger'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install multi_logger

## Usage

To setup a logger, create a initializer script like `[Rails.root]/config/initializers/logger.rb`. In the script, call `MultiLogger.add_logger(log_name)` to create new logger. For example, calling `MultiLogger.add_logger('mail')` will create a log file located at `log/mail.log`.

In Rails, you can access the logger by calling `logger.log_name` or `Rails.logger.log_name`. For example, calling `logger.mail.debug('42')` will log the message in the mail log.

Note that log_name must not collide with existing method names in Rails logger, so names such as 'debug' or 'info' can not be used. You should try calling `add_logger` in Rails console to test if it is ok or raises an error.

## Advanced

You can assign formatter to loggers directly, or pass the formatter during setup:

    formatter = Proc.new{|severity, time, progname, msg|
      formatted_severity = sprintf("%-5s",severity.to_s)
      formatted_time = time.strftime("%Y-%m-%d %H:%M:%S")
      "[#{formatted_severity} #{formatted_time} #{$$}] #{msg.to_s.strip}\n"
    }
    MultiLogger.add_logger('mail', formatter:formatter)
    MultiLogger.add_logger('user', formatter:formatter)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License (See LICENSE.txt)
