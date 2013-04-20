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

Call `MultiLogger.add_logger(log_name)` to create new logger. For example, calling `MultiLogger.add_logger('mail')` will create a log file located at `log/mail.log`. Usually I create an init script like `[Rails.root]/config/initializers/logger.rb` to call the `add_logger` method.

Initialized logs can be accessed from `loggers.log_name` or `MultiLogger.log_name`. For example, I can log a debug message in the mails log by calling `Rails.loggers.mail.debug('msg')`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
