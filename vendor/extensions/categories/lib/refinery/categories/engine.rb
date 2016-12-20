module Refinery
  module Categories
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Categories

      engine_name :refinery_categories

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "categories"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.categories_admin_categories_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Categories)
      end
    end
  end
end
