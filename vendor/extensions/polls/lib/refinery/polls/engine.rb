module Refinery
  module Polls
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Polls

      engine_name :refinery_polls

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "polls"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.polls_admin_polls_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Polls)
      end
    end
  end
end
