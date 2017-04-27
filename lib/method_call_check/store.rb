require 'singleton'
require 'json'
require 'active_support/core_ext/module/delegation'

module MethodCallCheck
  class Store
    include Singleton

    attr_reader :client

    def initialize
      @client = Redis.new(host: MethodCallCheck.configuration.redis_host, port: MethodCallCheck.configuration.redis_port)
    end

    class << self
      delegate(
        :client,
        :register_instance_method,
        :instance_method_registered?,
        :instance_method_registered_at,
        :store_instance_method_call,
        :stored_instance_method_call_stacks,
        :stored_instance_method_call_count,
        :register_class_method,
        :class_method_registered?,
        :class_method_registered_at,
        :store_class_method_call,
        :stored_class_method_call_stacks,
        :stored_class_method_call_count,
        to: :instance)
    end

    def register_instance_method(name)
      @client.sadd('method_call_check:instance_methods:registered', name)
      @client.set("method_call_check:instance_methods:registered_at:#{name}",  Time.now.to_i)
    end

    def instance_method_registered?(name)
      @client.sismember('method_call_check:instance_methods:registered', name)
    end

    def instance_method_registered_at(name)
      @client.get("method_call_check:instance_methods:registered_at:#{name}").to_i
    end

    def store_instance_method_call(name, stack)
      @client.zadd("method_call_check:instance_methods:calls:#{name}", Time.now.to_i, stack.to_json)
      @client.zremrangebyrank("method_call_check:instance_methods:calls:#{name}", 10, -1)
      @client.incr("method_call_check:instance_methods:counts:#{name}")
    end

    def stored_instance_method_call_stacks(name)
      @client.zrange("method_call_check:instance_methods:calls:#{name}", 0, -1)
    end

    def stored_instance_method_call_count(name)
      @client.get("method_call_check:instance_methods:counts:#{name}").to_i
    end

    def register_class_method(name)
      @client.sadd('method_call_check:class_methods:registered', name)
      @client.set("method_call_check:class_methods:registered_at:#{name}",  Time.now.to_i)
    end

    def class_method_registered?(name)
      @client.sismember('method_call_check:class_methods:registered', name)
    end

    def class_method_registered_at(name)
      @client.get("method_call_check:class_methods:registered_at:#{name}").to_i
    end

    def store_class_method_call(name, stack)
      @client.zadd("method_call_check:class_methods:calls:#{name}", Time.now.to_i, stack.to_json)
      @client.zremrangebyrank("method_call_check:class_methods:calls:#{name}", 10, -1)
      @client.incr("method_call_check:class_methods:counts:#{name}")
    end

    def stored_class_method_call_stacks(name)
      @client.zrange("method_call_check:class_methods:calls:#{name}", 0, -1)
    end

    def stored_class_method_call_count(name)
      @client.get("method_call_check:class_methods:counts:#{name}").to_i
    end

  end
end
