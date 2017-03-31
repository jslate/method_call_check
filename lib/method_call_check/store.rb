require 'singleton'
require 'json'

module MethodCallCheck
  class Store
    include Singleton

    attr_accessor :client

    def self.client=(redis_client)
      self.instance.client = redis_client
    end

    def register_method(name)
      @client.sadd('methodCalls:registered_methods', name)
    end

    def method_registered?(name)
      @client.sismember('methodCalls:registered_methods', name)
    end

    def store_method_call(name, stack)
      @client.zadd("methodCalls:calls:#{name}", Time.now.to_i, stack.to_json)
    end

    def stored_method_call_stacks(name)
      @client.zrange("methodCalls:calls:#{name}", 0, -1)
    end

    def register_class_method(name)
      @client.sadd('methodCalls:registered_class_methods', name)
    end

    def class_method_registered?(name)
      @client.sismember('methodCalls:registered_class_methods', name)
    end

    def store_class_method_call(name, stack)
      @client.zadd("methodCalls:class_method_calls:#{name}", Time.now.to_i, stack.to_json)
    end

    def stored_class_method_call_stacks(name)
      @client.zrange("methodCalls:class_method_calls:#{name}", 0, -1)
    end


  end
end
