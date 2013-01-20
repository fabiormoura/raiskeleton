require 'raiskeleton/section'
module Raiskeleton
  class Layout
    #attr_accessor :path
    attr_accessor :name
    attr_accessor :sections
    def initialize(name)
      raise "layout name cannot be nil or empty" if name.nil? || name.empty?
      self.name = name
      self.sections = {}
    end

    def update_section(name, &block)
      raise Raiskeleton::Section::INVALID_NAME if not Raiskeleton::Section.valid_name?(name)
      if not sections.has_key?(name)
        sections[name] = Raiskeleton::Section.new(name)
      end
      block.call(sections[name]) if block_given?
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
