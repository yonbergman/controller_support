module FooSupport # a complex support
  extend ControllerSupport::Base

  before_filter :foo
  helper_method :dynamic_foo
  after_filter :extended

  included do
    define_method :dynamic_foo do
      "dynamic_foo"
    end
  end

  def foo
    "foo"
  end

  module ClassMethods
    def class_foo
      "class_foo"
    end
  end

end


module BarSupport # simple support
  extend ControllerSupport::Base

  def bar
    "bar"
  end
end


module FoobarSupport  # example for inheritance of simple support
  extend ControllerSupport::Base

  include BarSupport

  def foobar
    "foobar"
  end
end

module WrapFooSupport # example for inheritance of complex support
  extend ControllerSupport::Base

  include FooSupport
end