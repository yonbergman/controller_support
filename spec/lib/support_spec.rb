require 'spec_helper'
require 'spec_helpers/dummy_classes'
require 'spec_helpers/example_controller_supports'
require 'spec_helpers/mixed_helpers'

describe ControllerSupport::Base do

  subject { create_mixed_instance(DummyMailer, FooSupport) }

  describe "Basic ActiveSupport::Concern behaviours" do
    it "should mix in methods into class" do
      should respond_to :foo
    end

    it "should run the included block" do
      should respond_to :dynamic_foo
    end

    it "should support dependencies" do
      foobar_instance = create_mixed_instance(DummyMailer, FoobarSupport)
      foobar_instance.should respond_to :foobar
      foobar_instance.should respond_to :bar
    end

    it "should support the ClassMethod submodule" do
      subject.class.should respond_to :class_foo
    end

  end

  describe "extended Controller Support behaviour" do
    let(:foo_controller) { create_mixed_class(DummyController, FooSupport) }
    let(:wrapped_foo_controller) { create_mixed_class(DummyController, WrapFooSupport) }

    it "can set before_filters" do
      foo_controller.before_filters.should eq([:foo])
    end

    it "can set helper_methods" do
      foo_controller.helper_methods.should eq([:dynamic_foo])
    end

    it "can set before_filters even via inheritance" do
      wrapped_foo_controller.before_filters.should eq([:foo])
    end

    it "doesn't override any after_filters already set on the controller" do

      class ControllerWithAfterFilter < DummyController
        after_filter :original
        include FooSupport
      end

      ControllerWithAfterFilter.after_filters.should eq([:original, :extended])
    end
  end

end