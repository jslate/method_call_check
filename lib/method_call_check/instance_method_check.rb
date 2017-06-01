require 'method_call_check/store'

module MethodCallCheck::InstanceMethodCheck

  def is_method_called?(method_name)
    return unless MethodCallCheck.configuration.enabled?
    MethodCallCheck::Store.register_instance_method("#{self.name}::#{method_name}")

    alias_method "orig_#{method_name}".to_sym, method_name
    define_method(method_name) do |*args|
      MethodCallCheck::Store.store_instance_method_call("#{self.class.name}::#{method_name}", caller)
      send("orig_#{method_name}".to_sym, *args)
    end
  end

end
