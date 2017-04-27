require 'test_helper'

class MethodCallCheckTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MethodCallCheck::VERSION
  end

  def test_method_registered
    assert_equal true, MethodCallCheck::Store.instance_method_registered?(:method_to_test)
    assert_includes (Time.now.to_i - 10)..(Time.now.to_i), MethodCallCheck::Store.instance_method_registered_at(:method_to_test)
  end

  def test_method_called
    reset_calls
    assert_nil MethodCallCheck::Store.stored_instance_method_call_stacks(:method_to_test)[0]
    TestObject.new.method_to_test
    refute_nil MethodCallCheck::Store.stored_instance_method_call_stacks(:method_to_test)[0]
    assert_match 'method_call_check_test.rb', MethodCallCheck::Store.stored_instance_method_call_stacks(:method_to_test)[0]
    assert_equal 1, MethodCallCheck::Store.stored_instance_method_call_count(:method_to_test)
  end

  def test_method_called_multiple_times
    reset_calls
    test_object = TestObject.new
    6.times { test_object.method_to_test }
    assert_equal 6, MethodCallCheck::Store.stored_instance_method_call_count(:method_to_test)
  end

  def test_method_called_trucated
    reset_calls
    test_object = TestObject.new
    # This is silly, but it is an easy way to get 12 different
    # calls with 12 _slightly_ different stack traces
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    test_object.method_to_test
    assert_equal 12, MethodCallCheck::Store.stored_instance_method_call_count(:method_to_test)
    assert_equal 10, MethodCallCheck::Store.stored_instance_method_call_stacks(:method_to_test).count
  end

  def test_class_method_registered
    assert_equal true, MethodCallCheck::Store.class_method_registered?(:class_method_to_test)
    assert_includes (Time.now.to_i - 10)..(Time.now.to_i), MethodCallCheck::Store.class_method_registered_at(:class_method_to_test)
  end

  def test_class_method_called
    reset_calls
    assert_nil MethodCallCheck::Store.stored_class_method_call_stacks(:class_method_to_test)[0]
    TestObject.class_method_to_test
    refute_nil MethodCallCheck::Store.stored_class_method_call_stacks(:class_method_to_test)[0]
    assert_match 'method_call_check_test.rb', MethodCallCheck::Store.stored_class_method_call_stacks(:class_method_to_test)[0]
    assert_equal 1, MethodCallCheck::Store.stored_class_method_call_count(:class_method_to_test)
  end

  def test_class_method_called_multiple_times
    reset_calls
    6.times { TestObject.class_method_to_test }
    assert_equal 6, MethodCallCheck::Store.stored_class_method_call_count(:class_method_to_test)
  end

  def test_class_method_called_trucated
    reset_calls
    # The same silliness as above
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    TestObject.class_method_to_test
    assert_equal 12, MethodCallCheck::Store.stored_class_method_call_count(:class_method_to_test)
    assert_equal 10, MethodCallCheck::Store.stored_class_method_call_stacks(:class_method_to_test).count
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
