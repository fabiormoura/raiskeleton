require 'raiskeleton/page'
require 'raiskeleton/group'

module Raiskeleton
  class Pages
    attr_accessor :name
#    attr_accessor :default_layout
    attr_accessor :pages
    attr_accessor :sections

    def initialize(name)
      raise "name cannot not be nil or empty?" if name.nil? || name.empty?
      self.name = name
      self.pages = {}
      self.sections = {}
    end

#    def get_layout(group)
#      return group.get_default_layout if self.default_layout.blank?
#      return group.get_layout(self.default_layout)
#    end

    def register_page(action,&block)
      if not pages.has_key?(action)
        pages[action] = Raiskeleton::Page.new(action)
      end
      block.call(pages[action]) if block_given?
    end

    def update_section(name,&block)
      if not sections.has_key?(name)
        sections[name] = Raiskeleton::Section.new(name)
      end
      block.call(sections[name]) if block_given?
    end

#    def render_sections_to_view(view,group)
#      page = self.page_list[view.controller.action_name.to_s] if self.page_list.has_key? view.controller.action_name.to_s
#      if page.present? && page.default_layout.present?
#        layout = group.get_layout(page.default_layout)
#      elsif self.default_layout.present?
#        layout = group.get_layout(self.default_layout)
#      else
#        layout = group.get_default_layout
#      end

#      raise "layout name should be specified" if layout.nil?

 #     all_sections = layout.sections.merge(self.sections)
 #     all_sections.merge!(page.sections) if page.present?

 #     all_sections.each_value do |section|
 #       view.content_for section.name do
 #         cells_content = ActiveSupport::SafeBuffer.new
 #         section.cells.each do |cell|
 #           cells_content << view.render_cell(cell[:name], cell[:state])
 #         end

 #         cells_content
 #       end
 #     end
 #     return layout
 #   end

  end
end
