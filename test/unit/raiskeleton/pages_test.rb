require 'shoulda'
require 'mocha'
require 'pages'

module Raiskeleton
  class PagesTest < Test::Unit::TestCase
    context "name" do
      should "create a pages object with given name" do
        name = stub(:empty? => false)
        pages = Raiskeleton::Pages.new name
        assert_equal name, pages.name
      end

      should "raise an exception when name is nil" do
        assert_raise(RuntimeError) do
          Raiskeleton::Pages.new nil
        end
      end

      should "raise an exception when name is empty" do
        assert_raise(RuntimeError) do
          Raiskeleton::Pages.new ""
        end
      end
    end

    context "sections" do
      setup do
        name = stub(:empty? => false)
        @pages = Raiskeleton::Pages.new name
      end

      should "create pages with no sections" do
        assert @pages.sections.empty?
      end

      should "create a section with given name" do
        name = stub
        section = stub

        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section)

        @pages.update_section(name)

        assert @pages.sections.key?(name)
        assert_equal section, @pages.sections[name]
      end

      should "not create a new section when name already exists" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section.expects(:new).with(name).returns(section)

        @pages.update_section(name)
        @pages.update_section(name)
        assert_equal 1, @pages.sections.keys.length
      end

      should "call block when updating section" do
        name = stub
        section = stub
        Raiskeleton::Section.stubs(:name_valid?).returns(true)
        Raiskeleton::Section::expects(:new).with(name).returns(section)
        block = Proc.new {}
        block.expects(:call).with(section)

        @pages.update_section(name,&block)
      end
    end

    context "pages" do
      setup do
        name = stub(:empty? => false)
        @pages = Raiskeleton::Pages.new name
      end

      should "create pages with no pages" do
        assert @pages.pages.empty?
      end

      should "register a page with given action" do
        action = stub(:empty? => false)
        page = stub
        Raiskeleton::Page.stubs(:new).with(action).returns(page)

        @pages.register_page(action)

        assert @pages.pages.key?(action)
        assert_equal page, @pages.pages[action]
      end

      should "not register a page when another one was already registered" do
        action = stub
        page = stub
        Raiskeleton::Page.stubs(:action_valid?).returns(true)
        Raiskeleton::Page.expects(:new).with(action).returns(page)

        @pages.register_page(action)
        @pages.register_page(action)
        assert_equal 1, @pages.pages.keys.length
      end

      should "call block when registering a page" do
        action = stub
        page = stub
        Raiskeleton::Page.stubs(:action_valid?).returns(true)
        Raiskeleton::Page::expects(:new).with(action).returns(page)
        block = Proc.new {}
        block.expects(:call).with(page)

        @pages.register_page(action,&block)
      end
    end
  end
end
