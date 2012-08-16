module Raiskeleton
  class Page
    attr_accessor :action
    attr_accessor :sections
    attr_accessor :default_layout

    def initialize(action)
      raise "action should not be blank" if action.blank?
      self.action = action
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
  end
end