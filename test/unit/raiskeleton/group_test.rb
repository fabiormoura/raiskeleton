require 'test/unit'
require 'shoulda'
require 'group'
require 'mocha'

module Raiskeleton
  class GroupTest < Test::Unit::TestCase
    context "name" do
      setup do
        Raiskeleton::Group.registered_group_names.clear
      end

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

      should "raise an exception when name is duplicated" do
        Raiskeleton::Group.new "group"
        assert_raise(RuntimeError) do
          Raiskeleton::Group.new "group"
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
        layout = stub

        Raiskeleton::Layout.expects(:new).with(name).returns(layout)

        @group.add_layout(name)

        assert @group.layouts.key?(name)
        assert_equal layout.class, @group.layouts[name].class
      end

      should "raise an exception when layout is already exists" do
        name = stub
        Raiskeleton::Layout.stubs(:name_valid?).returns(true)
        @group.add_layout(name)
        assert_raise(RuntimeError) do
          @group.add_layout(name)
        end
      end

      should "call block when adding layout" do
        name = stub
        layout = stub
        Raiskeleton::Layout.stubs(:name_valid?).returns(true)
        Raiskeleton::Layout::expects(:new).with(name).returns(layout)
        block = Proc.new { }
        block.expects(:call).with(layout)

        @group.add_layout(name,&block)
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
        Raiskeleton::Layout.expects(:new).with(layout_name).returns(stub)

        group = Raiskeleton::Group.new name
        group.add_layout(layout_name)
        group.default_layout = layout_name
        assert_equal layout_name, group.default_layout
      end
    end
  end
end
