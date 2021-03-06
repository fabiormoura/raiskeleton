require 'raiskeleton/section'
module Raiskeleton
  class Layout
    attr_accessor :path
    attr_accessor :name
    attr_accessor :sections

    def initialize(name)
      raise "layout name cannot be nil or empty" if not Raiskeleton::Layout.name_valid?(name)
      self.name = name
      self.sections = {}
    end

    def update_section(name, &block)
      if not sections.has_key?(name)
        sections[name] = Raiskeleton::Section.new(name)
      end
      sections[name].instance_eval(&block) if block_given?
    end

    def self.name_valid?(name)
      !name.nil? && !name.empty?
    end

    def validate!
      if path.nil? || path.empty?
        raise "layout #{name} has not path to the layout file defined"
      end
    end

    #def render_sections_to_view(view)
    #  self.sections.each_value do |section|
    #    view.content_for section.name do
    #      cells_content = ActiveSupport::SafeBuffer.new
    #      section.cells.each do |cell|
    #        cells_content << view.render_cell(cell[:name], cell[:state])
    #      end

    #      cells_content
    #    end
    #  end
    #end
  end
end
