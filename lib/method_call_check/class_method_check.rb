module MethodCallCheck::ClassMethodCheck

  def is_class_method_called?(method_name)
    return unless MethodCallCheck.configuration.enabled?
    MethodCallCheck::Store.register_class_method("#{self.name}::#{method_name}")
    singleton_class.send(:alias_method, "orig_#{method_name}".to_sym, method_name)
    define_singleton_method(method_name) do |*args|
      MethodCallCheck::Store.store_class_method_call("#{self.name}::#{method_name}", caller)
      if MethodCallCheck.configuration.fail_on_call?
        raise MethodCallCheck::MethodCallError
      else
        self.send("orig_#{method_name}".to_sym, *args)
      end
    end
  end

end
