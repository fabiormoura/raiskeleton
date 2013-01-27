require 'raiskeleton/group'
require 'raiskeleton/pages'

module Raiskeleton
  class Skeleton
    attr_accessor :groups
    attr_accessor :pages

    def initialize
      self.groups = {}
      self.pages = {}
    end

    def register_group(name,&block)
      if not groups.has_key?(name)
        groups[name] = Raiskeleton::Group.new(name)
      else
        raise "group #{name} was already registered"
      end
      groups[name].instance_eval(&block) if block_given?
      groups[name].validate!
    end

#    def get_group(group_name)
#      raise "group #{group_name} does not exist" unless self.groups.has_key?(group_name.to_s)
#      self.groups[group_name.to_s]
#    end

    def register_pages(name,&block)
      if not pages.has_key?(name)
        pages[name] = Raiskeleton::Pages.new(name)
      else
        raise "pages #{name} was already registered"
      end
      pages[name].instance_eval(&block) if block_given?
    end

#    def get_pages(pages_name)
#      raise "pages #{pages_name} does not exist" unless self.pages.has_key?(pages_name.to_s)
#      self.pages[pages_name.to_s]
#    end
  end
end
