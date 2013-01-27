module Raiskeleton
  module Rails
    module ActionController
      extend ActiveSupport::Concern

      included do
        append_view_path "app/skeletons/layouts"
      end

      module ClassMethods
        def skeleton_group(group_name)
           @@skeleton_group_name = group_name
        end

        def skeleton_group_name
          @@skeleton_group_name
        end

        def skeleton_pages(pages_name)
          @@skeleton_pages_name = pages_name
        end

        def skeleton_pages_name
          @@skeleton_pages_name
        end
      end
    end
  end
end
