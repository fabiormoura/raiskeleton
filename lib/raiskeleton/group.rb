require 'raiskeleton/layout'

module Raiskeleton
  class Group
    @@registered_group_names = []
    attr_accessor :layouts
    attr_accessor :name
    attr_accessor :default_layout

    def self.registered_group_names
      @@registered_group_names
    end

    def initialize(name)
      raise "group name cannot not be nil or empty" if name.nil? || name.empty?
      raise "group name already exists" if @@registered_group_names.include?(name)

      @@registered_group_names << name
      self.name = name
      self.layouts = {}
    end

    def add_layout(name, &block)
      raise "layout #{name} was already create to the group #{self.name}" if self.layouts.has_key?(name)

      layout = Raiskeleton::Layout.new(name)
      self.layouts[name] = layout
      layout.instance_eval(&block) if block_given?
    end

#    def get_layout(name)
#      raise "layout #{name} does not exist" unless self.layouts.has_key?(name.to_s)
#      self.layouts[name.to_s]
#   end

#    def get_default_layout
#      layout = self.get_layout(self.default_layout)
#      return layout
#    end
  end
end
