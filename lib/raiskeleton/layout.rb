require 'raiskeleton/section'
module Raiskeleton
  class Layout
    attr_accessor :path
    attr_accessor :name
    attr_accessor :sections
    def initialize(name)
      raise "layout name should not be blank" if name.blank?
      self.name = name
      self.sections = {}
    end

    def update_section(section_name,&block)
      raise "section name should not be blank" if section_name.blank?
      unless self.sections.has_key?(section_name.to_s)
        self.sections[section_name.to_s] = Raiskeleton::Section.new(section_name)
      end
      section = self.sections[section_name.to_s]
      block.call(section)
    end

    def render_sections_to_view(view)
      self.sections.each_value do |section|
        view.content_for section.name do
          cells_content = ActiveSupport::SafeBuffer.new
          section.cells.each do |cell|
            cells_content << view.render_cell(cell[:name], cell[:state])
          end

          cells_content
        end
      end
    end
  end
end