module MethodCallCheck::ClassMethodCheck

  def is_class_method_called?(method_name)
      MethodCallCheck::Store.instance.register_class_method(method_name)
      singleton_class.send(:alias_method, "orig_#{method_name}".to_sym, method_name)
      define_singleton_method(method_name) do |*args|
        MethodCallCheck::Store.instance.store_class_method_call(method_name, caller)
        self.send("orig_#{method_name}".to_sym, *args)
      end
  end

end
