require 'test/unit'
require 'shoulda'
require 'section'
require 'mocha'

module Raiskeleton
  class SectionTest < Test::Unit::TestCase
    context "name" do
      should "create a section with given name" do
        section = Raiskeleton::Section.new "right"
        assert_equal "right", section.name
      end

      should "raise a exception when name is nil" do
        assert_raise(RuntimeError) do
          Raiskeleton::Section.new nil
        end
      end

      should "raise an exception when name is empty" do
        assert_raise(RuntimeError) do
          Raiskeleton::Section.new ""
        end
      end
    end

    context "cells" do
      setup do
        name = stub(:nil? => false, :empty? => false)
        @section = Raiskeleton::Section.new name
      end

      should "create an section with no cells" do
        assert @section.cells.empty?
      end
    end

    context "render_cells" do
      setup do
        name = stub(:nil? => false, :empty? => false)
        @section = Raiskeleton::Section.new name
      end

      should "add a cell to be rendered" do
        state_args = [{:arg0 => 0, :arg1=> 1},"second_arg"]
        @section.render_cell :cell, :show, *state_args
        assert_equal :cell, @section.cells[0][:name]
        assert_equal :show, @section.cells[0][:state]
        assert_equal state_args, @section.cells[0][:args]
      end

      context "name" do
        should "raise an exception when name is nil" do
          assert_raise(RuntimeError) do
            @section.render_cell nil, stub, stub
          end
        end

        should "raise an exception when name is empty" do
          assert_raise(RuntimeError) do
            @section.render_cell "", stub, stub
          end
        end
      end

      context "show" do
        should "raise an exception when state is nil" do
          setup do

          end
          assert_raise(RuntimeError) do
            name = stub(:nil? => false, :empty? => false)
            @section.render_cell name, nil, stub
          end
        end

        should "raise an exception when state is empty" do
          assert_raise(RuntimeError) do
            name = stub(:nil? => false, :empty? => false)
            @section.render_cell name, "", stub
          end
        end
      end
    end
  end
end
