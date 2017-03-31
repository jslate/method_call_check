require 'method_call_check/store'

module MethodCallCheck::InstanceMethodCheck

  def is_method_called?(method_name)
    MethodCallCheck::Store.instance.register_method(method_name)

    alias_method "orig_#{method_name}".to_sym, method_name
    define_method(method_name) do |*args|
      MethodCallCheck::Store.instance.store_method_call(method_name, caller)
      send("orig_#{method_name}".to_sym, *args)
    end
  end

end
