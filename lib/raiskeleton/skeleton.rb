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

    def add_group(group_name,&block)
      group = Raiskeleton::Group.new(group_name)
      raise "group #{group.name} was already specified" if self.groups.has_key?(group.name.to_s)
      block.call(group)
      self.groups[group.name.to_s] = group
    end

    def get_group(group_name)
      raise "group #{group_name} does not exist" unless self.groups.has_key?(group_name.to_s)
      self.groups[group_name.to_s]
    end

    def add_pages(pages_name,&block)
      pages = Raiskeleton::Pages.new(pages_name)
      raise "pages #{pages.name} was already specified" if self.pages.has_key?(pages.name.to_s)
      block.call(pages)
      self.pages[pages.name.to_s] = pages
    end

    def get_pages(pages_name)
      raise "pages #{pages_name} does not exist" unless self.pages.has_key?(pages_name.to_s)
      self.pages[pages_name.to_s]
    end
  end
end
