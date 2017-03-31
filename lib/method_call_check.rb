require "method_call_check/version"
require "method_call_check/store"
require "method_call_check/class_method_check"
require "method_call_check/instance_method_check"

module MethodCallCheck

  extend ClassMethodCheck
  extend InstanceMethodCheck

end
