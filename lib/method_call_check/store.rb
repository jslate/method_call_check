require 'singleton'
require 'json'

module MethodCallCheck
  class Store
    include Singleton

    attr_accessor :client

    def self.client=(redis_client)
      self.instance.client = redis_client
    end

    def register_instance_method(name)
      @client.sadd('method_call_check:instance_methods:registered', name)
    end

    def instance_method_registered?(name)
      @client.sismember('method_call_check:instance_methods:registered', name)
    end

    def store_instance_method_call(name, stack)
      @client.zadd("method_call_check:instance_methods:calls:#{name}", Time.now.to_i, stack.to_json)
      @client.incr("method_call_check:instance_methods:counts:#{name}")
    end

    def stored_instance_method_call_stacks(name)
      @client.zrange("method_call_check:instance_methods:calls:#{name}", 0, -1)
    end

    def register_class_method(name)
      @client.sadd('method_call_check:class_methods:registered', name)
    end

    def class_method_registered?(name)
      @client.sismember('method_call_check:class_methods:registered', name)
    end

    def store_class_method_call(name, stack)
      @client.zadd("method_call_check:class_methods:calls:#{name}", Time.now.to_i, stack.to_json)
      @client.incr("method_call_check:class_methods:counts:#{name}")
    end

    def stored_class_method_call_stacks(name)
      @client.zrange("method_call_check:class_methods:calls:#{name}", 0, -1)
    end


  end
end
