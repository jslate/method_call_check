$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'method_call_check'
require 'minitest/autorun'
require 'redis'

def client
  @client ||= Redis.new(host: 'localhost', port: 6379)
end

def reset_calls
  client.del("method_call_check:instance_methods:counts:method_to_test")
  client.del("method_call_check:instance_methods:calls:method_to_test")
  client.del("method_call_check:class_methods:counts:class_method_to_test")
  client.del("method_call_check:class_methods:calls:class_method_to_test")
end

def reset_registrations
  client.del("method_call_check:instance_methods:registered_at:method_to_test")
  client.del("method_call_check:class_methods:registered_at:class_method_to_test")
end

reset_calls
reset_registrations

MethodCallCheck::Store.client = client
