require "method_call_check/version"
require "method_call_check/store"
require "method_call_check/class_method_check"
require "method_call_check/instance_method_check"

module MethodCallCheck

  extend ClassMethodCheck
  extend InstanceMethodCheck

  class Configuration
    attr_accessor :redis_host, :redis_port
    def initialize
      @redis_host = 'localhost'
      @redis_port = 6379
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
