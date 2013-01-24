require 'test/unit'
require 'shoulda'
require 'layout'
require 'mocha'

module Raiskeleton
  class LayoutTest < Test::Unit::TestCase
    context "name" do
      should "create a layout with given name and when name_valid? is true" do
        name = stub
        Raiskeleton::Layout.stubs(:name_valid?).with(name).returns(true).once
        layout = Raiskeleton::Layout.new name
        assert_equal name, layout.name
      end

      should "raise an exception when name_valid? is false" do
        name = stub
        Raiskeleton::Layout.stubs(:name_valid?).with(name).returns(false).once
        assert_raise(RuntimeError) do
          Raiskeleton::Layout.new name
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

        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section)

        @layout.update_section(name)

        assert @layout.sections.key?(name)
        assert_equal section, @layout.sections[name]
      end

      should "not create a new section when name already exists" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section).once

        @layout.update_section(name)
        @layout.update_section(name)
        assert_equal 1, @layout.sections.keys.length
      end

      should "call block when updating section" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section::expects(:new).with(name).returns(section)
        block = Proc.new { }
        block.expects(:call).with(section)

        @layout.update_section(name,&block)
      end
    end

    context "name_valid?" do
      should "return false when name is nil" do
        assert_equal false, Raiskeleton::Layout.name_valid?(nil)
      end

      should "return false when name is empty" do
        assert_equal false, Raiskeleton::Layout.name_valid?("")
      end

      should "return true when name is not empty and not nil" do
        assert Raiskeleton::Layout.name_valid?("layout")
      end
    end
  end
end
