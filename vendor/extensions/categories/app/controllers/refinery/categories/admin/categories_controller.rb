module Refinery
  module Categories
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/categories/category',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def category_params
          params.require(:category).permit(:name)
        end
      end
    end
  end
end
