#
# A dummy controller - has the following class methods
#  * before_filter
#  * around_filter
#  * after_filter
#  * helper_method
#
# for each of the methods it also has matching getter method
#  * before_filters
#  * around_filters
#  * after_filters
#  * helper_methods
#
class DummyController

  [:before_filter, :after_filter, :around_filter, :helper_method].each do |controller_func|
    getter = "#{controller_func}s"

    self.class.send :define_method, getter do
      @_symbols ||= {}
      @_symbols[controller_func] ||= []
    end

    self.class.send :define_method, controller_func do |*symbols|
      send(getter).concat symbols
    end
  end

end

# A DummyMailer - does nothing :)
class DummyMailer

end