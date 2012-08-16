require 'raiskeleton/layout'

module Raiskeleton
  class Group
    attr_accessor :layouts
    attr_accessor :name
    attr_accessor :default_layout

    def default_layout=(name)
      raise "There is no layout to specified name #{name}" unless self.layouts.has_key?(name.to_s)
      @default_layout = name
    end

    def initialize(name)
      raise "group name should not be blank" if name.blank?
      self.name = name
      self.layouts = {}
    end

    def add_layout(name)
      layout = Raiskeleton::Layout.new(name)
      raise "layout #{layout.name} was already specified" if self.layouts.has_key?(layout.name.to_s)
      yield(layout)
      self.layouts[layout.name.to_s] = layout
    end

    def get_layout(name)
      raise "layout #{name} does not exist" unless self.layouts.has_key?(name.to_s)
      self.layouts[name.to_s]
    end

    def get_default_layout
      layout = self.get_layout(self.default_layout)
      return layout
    end
  end
end