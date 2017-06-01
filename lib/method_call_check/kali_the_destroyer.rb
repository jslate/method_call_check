require 'method_call_check/store'

module MethodCallCheck::KaliTheDestroyer

  def self.destroy_all
    MethodCallCheck::Store.registered_instance_methods.each do |method_name|
      MethodCallCheck::Store.client.del("method_call_check:instance_methods:counts:#{method_name}")
      MethodCallCheck::Store.client.del("method_call_check:instance_methods:calls:#{method_name}")
      MethodCallCheck::Store.client.del("method_call_check:instance_methods:registered_at:#{method_name}")
    end

    MethodCallCheck::Store.registered_class_methods.each do |method_name|
      MethodCallCheck::Store.client.del("method_call_check:class_methods:counts:#{method_name}")
      MethodCallCheck::Store.client.del("method_call_check:class_methods:calls:#{method_name}")
      MethodCallCheck::Store.client.del("method_call_check:class_methods:registered_at:#{method_name}")
    end

    MethodCallCheck::Store.client.del('method_call_check:instance_methods:registered')
    MethodCallCheck::Store.client.del('method_call_check:class_methods:registered')
  end

end
