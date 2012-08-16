require 'rails/railtie'
require 'raiskeleton/helpers/settings'
require 'raiskeleton'
module Raiskeleton
  class Railtie < ::Rails::Railtie
    include Raiskeleton::Settings

    setting :load_paths, [File.expand_path('app/skeletons/groups'),File.expand_path('app/skeletons/pages')]

    config.to_prepare do
      Raiskeleton.load!
      Railtie.files_in_load_path.each{|file| load file }
    end

    private

    def self.files_in_load_path
      load_paths.flatten.compact.uniq.collect{|path| Dir["#{path}/**/*.rb"] }.flatten
    end

  end
end