# A bunch of helpers to help mix in modules for test cases
# to make sure each test is contained

def create_mixed_class(base_class, support)
  klass = Class.new(base_class)
  klass.send :include, support
  klass
end

def create_mixed_instance(base_class, support)
  create_mixed_class(base_class, support).new
end
