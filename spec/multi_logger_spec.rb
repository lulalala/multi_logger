require 'helper'
require 'multi_logger'

require 'logger'
require 'active_support/core_ext/string'

# Dummy class to avoid loading Rails
module Rails
  def self.root
    Pathname.new('./spec/')
  end
end

describe MultiLogger do
  it 'has version' do
    MultiLogger.const_get('VERSION').wont_be_empty
  end

  describe '.add_logger' do
    it 'raises error if name already in use as method name' do
      lambda { MultiLogger.add_logger('object_id')  }.must_raise RuntimeError
    end
    it 'defines a instance method in Rails Logger class linking to custom logger' do
      rails_logger_klass = Class.new
      MultiLogger.stubs(:get_rails_logger_class).returns(rails_logger_klass)

      logger = Logger.new('test')
      Logger.stubs(:new).returns(logger)

      MultiLogger.add_logger('payment').must_equal logger

      rails_logger_klass.new.payment.must_equal logger
    end
    it 'assigns formatter to custom logger' do
      rails_logger_klass = Class.new
      MultiLogger.stubs(:get_rails_logger_class).returns(rails_logger_klass)

      logger = Logger.new('test')
      Logger.stubs(:new).returns(logger)

      formatter = mock('formatter')
      MultiLogger.add_logger('fb',{formatter:formatter}).must_equal logger

      rails_logger_klass.new.fb.must_equal logger
      logger.formatter.must_equal formatter
    end
  end

  describe '.get_path' do
    it '' do
      MultiLogger.send(:get_path,'parser').to_s.must_equal './spec/log/parser.log'
    end
    it 'uses path as file path different to name' do
      MultiLogger.send(:get_path,'fb','facebook').to_s.must_equal './spec/log/facebook.log'
    end
    it 'uses path as file path (relative to Rails root) different to name' do
      MultiLogger.send(:get_path,'fb','facebook').to_s.must_equal './spec/log/facebook.log'
    end
    it 'uses path as file path as is if it contains slash' do
      MultiLogger.send(:get_path,'fb','./facebook').to_s.must_equal './facebook.log'
    end
    it 'does not append .log if path already ends with it' do
      MultiLogger.send(:get_path,'fb','./facebook.log').to_s.must_equal './facebook.log'
    end
  end
end
