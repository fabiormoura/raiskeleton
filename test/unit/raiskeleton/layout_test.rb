require 'test/unit'
require 'shoulda'
require 'layout'
require 'mocha'

module Raiskeleton
  class LayoutTest < Test::Unit::TestCase
    context "name" do
      should "create a layout with the given name" do
        layout = Raiskeleton::Layout.new "layout"
        assert_equal "layout", layout.name
      end

      should "raise and exception when name is nil" do
        assert_raise(RuntimeError) do
          layout = Raiskeleton::Layout.new nil
        end
      end

      should "raise and exception when name is empty" do
        assert_raise(RuntimeError) do
          layout = Raiskeleton::Layout.new ""
        end
      end
    end

    context "sections" do
      setup do
        name = stub(:nil? => false, :empty? => false)
        @layout = Raiskeleton::Layout.new name
      end
      should "create a layout with no sections" do
        assert @layout.sections.empty?
      end

      should "create a section with given name" do
        name = stub
        section = stub

        Raiskeleton::Section.stubs(:valid_name?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(stub)

        @layout.update_section(name)

        assert @layout.sections.key?(name)
        assert_equal section.class, @layout.sections[name].class
      end

      should "raise an exception when section name is not valid" do
        Raiskeleton::Section.stubs(:valid_name?).returns(false)
        assert_raise(RuntimeError) do
          @layout.update_section(stub)
        end
      end

      should "not create a new section when name already exists" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:valid_name?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section).once

        @layout.update_section(name)
        @layout.update_section(name)
        assert_equal 1, @layout.sections.keys.length
      end

      should "call block when updating section" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:valid_name?).returns(true)
        Raiskeleton::Section::expects(:new).with(name).returns(section)
        block = Proc.new { }
        block.expects(:call).with(section)

        @layout.update_section(name,&block)
      end
    end
  end
end
