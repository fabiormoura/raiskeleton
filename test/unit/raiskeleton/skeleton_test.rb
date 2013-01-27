require 'test/unit'
require 'shoulda'
require 'mocha'
require 'skeleton'

module Raiskeleton
  class SkeletonTest < Test::Unit::TestCase
    context "initialize" do
      should "create skeleton with empty groups" do
        skeleton = Raiskeleton::Skeleton.new
        assert skeleton.groups.empty?
      end

      should "create skeleton with empty pages" do
        skeleton = Raiskeleton::Skeleton.new
        assert skeleton.pages.empty?
      end
    end

    context "register_group" do
      setup do
        @skeleton = Raiskeleton::Skeleton.new
      end

      should "register group with given name" do
        name = stub
        group = stub_everything
        Raiskeleton::Group.stubs(:new).with(name).returns(group)
        @skeleton.register_group(name)

        assert_equal group, @skeleton.groups[name]
      end

      should "raise an exception when group already exists" do
        name = stub
        Raiskeleton::Group.stubs(:new).with(name).returns(stub_everything).once

        @skeleton.register_group(name)
        assert_raise(RuntimeError) do
          @skeleton.register_group(name)
        end
      end

      should "call block when registering a group" do
        name = stub
        group = stub_everything
        group.expects(:instance_eval)
        Raiskeleton::Group.expects(:new).with(name).returns(group)
        block = Proc.new { }

        @skeleton.register_group(name,&block)
      end

      should "call validate! when registering a group" do
        name = stub
        group = stub
        group.expects(:validate!)
        Raiskeleton::Group.expects(:new).with(name).returns(group)

        @skeleton.register_group(name)
      end
    end

    context "register_pages" do
      setup do
        @skeleton = Raiskeleton::Skeleton.new
      end

      should "register pages object with given name" do
        name = stub
        page = stub
        Raiskeleton::Pages.stubs(:new).with(name).returns(page)
        @skeleton.register_pages(name)

        assert_equal page, @skeleton.pages[name]
      end

      should "raise an exception when pages object already exists" do
        name = stub
        Raiskeleton::Pages.stubs(:new).with(name).returns(stub).once

        @skeleton.register_pages(name)
        assert_raise(RuntimeError) do
          @skeleton.register_pages(name)
        end
      end

      should "call block when registering a pages object" do
        name = stub(:empty? => false)
        pages = stub
        pages.expects(:instance_eval)
        Raiskeleton::Pages.expects(:new).with(name).returns(pages)
        block = Proc.new { }

        @skeleton.register_pages(name,&block)
      end
    end
  end
end

