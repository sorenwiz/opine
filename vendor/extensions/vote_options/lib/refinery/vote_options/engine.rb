module Refinery
  module VoteOptions
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::VoteOptions

      engine_name :refinery_vote_options

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "vote_options"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.vote_options_admin_vote_options_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::VoteOptions)
      end
    end
  end
end
