module Refinery
  module VoteOptions
    module Admin
      class VoteOptionsController < ::Refinery::AdminController

        crudify :'refinery/vote_options/vote_option',
                :title_attribute => 'text'

        private

        # Only allow a trusted parameter "white list" through.
        def vote_option_params
          params.require(:vote_option).permit(:text, :alias, :graph_rgb)
        end
      end
    end
  end
end
