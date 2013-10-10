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

To setup a logger, create an initializer script such as `[Rails.root]/config/initializers/logger.rb` with:

    MultiLogger.add_logger('mail')

This will create a log file located at `log/mail.log`.

Then In Rails, you can log by calling the following:

    Rails.logger.mail.debug('42')

The `Rails.` reference can be omitted at the usual places in Rails (e.g. controllers and views).

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

You can also create separate log file to each Rails environment:

    MultiLogger.add_logger('mail', {formatter:formatter, support_environments:true})

Or

    MultiLogger.add_logger('mail', support_environments:true)

For example if Rails.env == 'development', multi_logger will create mail_development.log file

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

MIT License (See LICENSE.txt)
