# Add extended ActionController behaviour.
ActionController::Base.class_eval do
  include ::Raiskeleton::Rails::ActionController
end

# Add extended ActionView behaviour.
ActionView::Base.class_eval do
  include ::Raiskeleton::Rails::ActionView
end