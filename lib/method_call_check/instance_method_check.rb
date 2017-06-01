require 'method_call_check/store'

module MethodCallCheck::InstanceMethodCheck

  def is_method_called?(method_name)
    return unless MethodCallCheck.configuration.enabled?
    MethodCallCheck::Store.register_instance_method("#{self.name}::#{method_name}")

    alias_method "orig_#{method_name}".to_sym, method_name
    define_method(method_name) do |*args|
      klass_name = self.class.ancestors.detect{|cls| cls.public_instance_methods(false).include?(method_name)}
      MethodCallCheck::Store.store_instance_method_call("#{klass_name}::#{method_name}", caller)
      send("orig_#{method_name}".to_sym, *args)
    end
  end

end
