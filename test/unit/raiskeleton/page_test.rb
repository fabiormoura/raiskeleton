require 'shoulda'
require 'mocha'
require 'page'

module Raiskeleton
  class PageTest < Test::Unit::TestCase
    context "action" do
      should "create a page with given action and when action_valid? is true" do
        action = stub
        Raiskeleton::Page.stubs(:action_valid?).with(action).returns(true).once
        page = Raiskeleton::Page.new action
        assert_equal action, page.action
      end

      should "raise a exception when action_valid? is false" do
        action = stub
        Raiskeleton::Page.stubs(:action_valid?).with(action).returns(false).once
        assert_raise(RuntimeError) do
          Raiskeleton::Page.new action
        end
      end
    end

    context "sections" do
      setup do
        action = stub
        Raiskeleton::Page.stubs(:action_valid?).with(action).returns(true)
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
        section.expects(:instance_eval)
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section::expects(:new).with(name).returns(section)
        block = Proc.new { }

        @page.update_section(name,&block)
      end
    end

    context "action_valid?" do
      should "return false when name is nil" do
        assert_equal false, Raiskeleton::Page.action_valid?(nil)
      end

      should "return false when name is empty" do
        assert_equal false, Raiskeleton::Page.action_valid?("")
      end

      should "return true when name is not empty and not nil" do
        assert Raiskeleton::Page.action_valid?("page")
      end
    end
  end
end
