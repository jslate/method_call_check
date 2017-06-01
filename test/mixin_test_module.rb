require 'test_helper'

module MixinTestModule

  include MethodCallCheck::MixinMethodCheck

  def mixin_method_to_test
  end
  is_method_called?(:mixin_method_to_test)

end
