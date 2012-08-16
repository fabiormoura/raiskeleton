require 'raiskeleton/page'
require 'raiskeleton/group'
module Raiskeleton
  class Pages
    attr_accessor :name
    attr_accessor :default_layout
    attr_accessor :page_list
    attr_accessor :sections

    def initialize(name)
      raise "pages name should not be blank" if name.blank?
      self.name = name
      self.page_list = {}
      self.sections = {}
    end

    def get_layout(group)
      return group.get_default_layout if self.default_layout.blank?
      return group.get_layout(self.default_layout)
    end

    def register_page(action,&block)
      raise "action should not be blank" if action.blank?
      unless self.page_list.has_key?(action.to_s)
        self.page_list[action.to_s] = Raiskeleton::Page.new(action)
      end
      page = self.page_list[action.to_s]
      block.call(page)
    end

    def update_section(section_name,&block)
      raise "section name should not be blank" if section_name.blank?
      unless self.sections.has_key?(section_name.to_s)
        self.sections[section_name.to_s] = Raiskeleton::Section.new(section_name)
      end
      section = self.sections[section_name.to_s]
      block.call(section)
    end

    def render_sections_to_view(view,group)
      page = self.page_list[view.controller.action_name.to_s] if self.page_list.has_key? view.controller.action_name.to_s
      if page.present? && page.default_layout.present?
        layout = group.get_layout(page.default_layout)
      elsif self.default_layout.present?
        layout = group.get_layout(self.default_layout)
      else
        layout = group.get_default_layout
      end

      raise "layout name should be specified" if layout.nil?

      all_sections = layout.sections.merge(self.sections)
      all_sections.merge!(page.sections) if page.present?

      all_sections.each_value do |section|
        view.content_for section.name do
          cells_content = ActiveSupport::SafeBuffer.new
          section.cells.each do |cell|
            cells_content << view.render_cell(cell[:name], cell[:state])
          end

          cells_content
        end
      end
      return layout
    end

  end
end