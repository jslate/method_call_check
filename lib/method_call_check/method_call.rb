require 'json'

class MethodCall
  attr_reader :time, :stack
  def initialize(time_int, stack_json)
    @time = Time.at(time_int)
    @stack = JSON.parse(stack_json)
  end
end
