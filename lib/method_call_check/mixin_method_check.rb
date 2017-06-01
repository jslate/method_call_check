require 'method_call_check/instance_method_check'

module MethodCallCheck::MixinMethodCheck
  def self.included klass
    klass.class_eval do
      extend MethodCallCheck::InstanceMethodCheck
    end
  end
end
