require 'test_helper'

class MethodCallCheckTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MethodCallCheck::VERSION
  end

  def test_method_registered
    assert_equal true, MethodCallCheck::Store.instance.instance_method_registered?(:method_to_test)
  end

  def test_method_called
    assert_nil MethodCallCheck::Store.instance.stored_instance_method_call_stacks(:method_to_test)[0]
    TestObject.new.method_to_test
    refute_nil MethodCallCheck::Store.instance.stored_instance_method_call_stacks(:method_to_test)[0]
    assert_match 'method_call_check_test.rb', MethodCallCheck::Store.instance.stored_instance_method_call_stacks(:method_to_test)[0]
  end

  def test_class_method_registered
    assert_equal true, MethodCallCheck::Store.instance.class_method_registered?(:class_method_to_test)
  end

  def test_class_method_called
    assert_nil MethodCallCheck::Store.instance.stored_class_method_call_stacks(:class_method_to_test)[0]
    TestObject.class_method_to_test
    refute_nil MethodCallCheck::Store.instance.stored_class_method_call_stacks(:class_method_to_test)[0]
    assert_match 'method_call_check_test.rb', MethodCallCheck::Store.instance.stored_class_method_call_stacks(:class_method_to_test)[0]
  end

  class TestObject

    extend MethodCallCheck::InstanceMethodCheck
    extend MethodCallCheck::ClassMethodCheck

    def method_to_test
    end
    is_method_called? :method_to_test

    def self.class_method_to_test
    end
    is_class_method_called? :class_method_to_test

  end

end
