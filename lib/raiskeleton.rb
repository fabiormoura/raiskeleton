module Raiskeleton
  class << self
    attr_accessor :skeleton
  end

  def self.load!
    self.skeleton = Raiskeleton::Skeleton.new
  end

  def self.register_group(group_name,&block)
    self.skeleton.add_group(group_name,&block)
  end

  def self.register_pages(pages_name,&block)
    self.skeleton.add_pages(pages_name,&block)
  end

  #def self.render_skeleton_layout(view)
  #  return if view.controller.class.skeleton_group_name.blank?
  #  group = Raiskeleton.skeleton.get_group(view.controller.class.skeleton_group_name)
  #  pages = Raiskeleton.skeleton.get_pages(view.controller.class.skeleton_pages_name) if view.controller.class.skeleton_pages_name.present?
  #  if pages.present?
  #    layout = pages.render_sections_to_view(view,group)
  #    view.render :template => layout.path
  #  else
  #    layout = group.get_default_layout
  #    layout.render_sections_to_view(view)
  #    view.render :template => layout.path
  #  end
  #end
end

require 'raiskeleton/rails/action_controller'
require 'raiskeleton/rails/action_view'
require 'raiskeleton/rails'
require 'raiskeleton/railtie'
require 'raiskeleton/group'
require 'raiskeleton/skeleton'
