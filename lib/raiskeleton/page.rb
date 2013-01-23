module Raiskeleton
  class Page
    attr_accessor :action
    attr_accessor :sections
#    attr_accessor :default_layout

    def initialize(action)
      raise "action cannot be nil or empty" if action.nil? || action.empty?

      self.action = action
      self.sections = {}
    end

    def update_section(name, &block)
      if not sections.has_key?(name)
        sections[name] = Raiskeleton::Section.new(name)
      end
      block.call(sections[name]) if block_given?
    end
  end
end
