$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'method_call_check'
require 'minitest/autorun'
require 'redis'

def reset_calls
  MethodCallCheck::Store.client.del("method_call_check:instance_methods:counts:MethodCallCheckTest::TestObject::method_to_test")
  MethodCallCheck::Store.client.del("method_call_check:instance_methods:calls:MethodCallCheckTest::TestObject::method_to_test")
  MethodCallCheck::Store.client.del("method_call_check:class_methods:counts:MethodCallCheckTest::TestObject::class_method_to_test")
  MethodCallCheck::Store.client.del("method_call_check:class_methods:calls:MethodCallCheckTest::TestObject::class_method_to_test")
end

def reset_registrations
  MethodCallCheck::Store.client.del("method_call_check:instance_methods:registered_at:MethodCallCheckTest::TestObject::method_to_test")
  MethodCallCheck::Store.client.del("method_call_check:class_methods:registered_at:MethodCallCheckTest::TestObject::class_method_to_test")
end

reset_calls
reset_registrations
