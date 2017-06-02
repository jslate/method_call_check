require "method_call_check/version"
require "method_call_check/store"
require "method_call_check/method_call"
require "method_call_check/class_method_check"
require "method_call_check/instance_method_check"
require "method_call_check/mixin_method_check"
require "method_call_check/kali_the_destroyer"
require "method_call_check/method_call_error"

module MethodCallCheck

  extend ClassMethodCheck
  extend InstanceMethodCheck

  class Configuration
    attr_accessor :redis_host, :redis_port, :enabled, :fail_on_call
    def initialize
      @redis_host = 'localhost'
      @redis_port = 6379
      @enabled = true
      @fail_on_call = false
    end
    def enabled?
      @enabled
    end
    def fail_on_call?
      @fail_on_call
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end

end
