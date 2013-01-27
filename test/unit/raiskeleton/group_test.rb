require 'test/unit'
require 'shoulda'
require 'group'
require 'mocha'

module Raiskeleton
  class GroupTest < Test::Unit::TestCase
    context "name" do
      should "create a group with the given name" do
        group = Raiskeleton::Group.new "group"
        assert_equal "group", group.name
      end

      should "raise an exception when name is nil" do
        assert_raise(RuntimeError) do
          Raiskeleton::Group.new nil
        end
      end

      should "raise an exception when name is empty" do
        assert_raise(RuntimeError) do
          Raiskeleton::Group.new ""
        end
      end
    end

    context "layouts" do
      setup do
        name = stub(:nil? => false, :empty? => false)
        @group = Raiskeleton::Group.new name
      end

      should "create a group with no layouts" do
        assert @group.layouts.empty?
      end

      should "create a layout with given name" do
        name = stub(:nil? => false, :empty? => false)
        layout = stub_everything

        Raiskeleton::Layout.expects(:new).with(name).returns(layout)

        @group.add_layout(name)

        assert @group.layouts.key?(name)
        assert_equal layout.class, @group.layouts[name].class
      end

      should "raise an exception when layout is already exists" do
        name = stub
        Raiskeleton::Layout.stubs(:name_valid?).returns(true)
        Raiskeleton::Layout.expects(:new).with(name).returns(stub_everything)
        @group.add_layout(name)
        assert_raise(RuntimeError) do
          @group.add_layout(name)
        end
      end

      should "call block when adding layout" do
        name = stub
        layout = stub_everything
        block = Proc.new {}
        layout.expects(:instance_eval)
        Raiskeleton::Layout.stubs(:name_valid?).returns(true)
        Raiskeleton::Layout.expects(:new).with(name).returns(layout)

        @group.add_layout(name,&block)
      end

      should "validate layout when creating it"do
        name = stub
        layout = stub
        layout.expects(:validate!)

        Raiskeleton::Layout.stubs(:name_valid?).returns(true)
        Raiskeleton::Layout.expects(:new).with(name).returns(layout)

        @group.add_layout(name)
      end

    end

    context "default_layout" do
      should "be empty when creating a new group" do
        name = stub(:nil? => false, :empty? => false)
        group = Raiskeleton::Group.new name

        assert_nil group.default_layout

      end

      should "define the default layout" do
        name = stub(:nil? => false, :empty? => false)
        layout_name = stub
        Raiskeleton::Layout.stubs(:name_valid?).returns(true)
        Raiskeleton::Layout.expects(:new).with(layout_name).returns(stub_everything)

        group = Raiskeleton::Group.new name
        group.add_layout(layout_name)
        group.default_layout = layout_name
        assert_equal layout_name, group.default_layout
      end
    end

    context "validate!" do
      setup do
        name = stub(:empty? => false)
        @group = Raiskeleton::Group.new name
      end

      should "raise an exception when default_layout is nil" do
        assert_raise(RuntimeError) do
          @group.validate!
        end
      end

      should "raise an exception when default_layout is empty" do
        @group.default_layout = stub(:empty? => true)

        assert_raise(RuntimeError) do
          @group.validate!
        end
      end

      should "raise an exception when default_layout is not one of layouts" do
        name = stub(:empty? => false)
        Raiskeleton::Layout.expects(:new).with(name).returns(stub_everything)
        @group.add_layout(name)
        @group.default_layout = name

        assert_raise(RuntimeError) do
          @group.validate!
        end
      end
    end
  end
end
