$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'method_call_check'
require 'minitest/autorun'
require 'redis'

def client
  Redis.new(host: 'localhost', port: 6379)
end

client.zremrangebyrank("methodCalls:calls:method_to_test", 0, -1)
client.zremrangebyrank("methodCalls:class_method_calls:class_method_to_test", 0, -1)

MethodCallCheck::Store.client = client
