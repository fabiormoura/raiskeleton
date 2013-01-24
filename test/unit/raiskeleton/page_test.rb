require 'shoulda'
require 'mocha'
require 'page'

module Raiskeleton
  class PageTest < Test::Unit::TestCase
    context "action" do
      should "create a page with given action" do
        action = stub(:empty? => false)
        page = Raiskeleton::Page.new action
        assert_equal action, page.action
      end

      should "raise an exception when action is nil" do
        assert_raise(RuntimeError) do
          Raiskeleton::Page.new nil
        end
      end

      should "raise an exception when action is empty" do
        assert_raise(RuntimeError) do
          Raiskeleton::Page.new ""
        end
      end
    end

    context "sections" do
      setup do
        action = stub(:empty? => false)
        @page = Raiskeleton::Page.new action
      end

      should "create a page with no sections" do
        assert @page.sections.empty?
      end

      should "create a section with given name" do
        name = stub
        section = stub

        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section)

        @page.update_section(name)

        assert @page.sections.key?(name)
        assert_equal section, @page.sections[name]
      end

      should "not create a new section when name already exists" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section).once

        @page.update_section(name)
        @page.update_section(name)
        assert_equal 1, @page.sections.keys.length
      end

      should "call block when updating section" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section::expects(:new).with(name).returns(section)
        block = Proc.new { }
        block.expects(:call).with(section)

        @page.update_section(name,&block)
      end
    end
  end
end
