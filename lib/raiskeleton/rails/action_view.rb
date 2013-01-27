require 'raiskeleton'
module Raiskeleton
  module Rails
    module ActionView
      extend ActiveSupport::Concern

      def render_skeleton
        Raiskeleton.render_skeleton_layout(self)
      end
    end
  end
end
