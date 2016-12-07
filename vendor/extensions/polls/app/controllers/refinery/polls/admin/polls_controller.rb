module Refinery
  module Polls
    module Admin
      class PollsController < ::Refinery::AdminController

        crudify :'refinery/polls/poll',
                :title_attribute => 'heading'

        private

        # Only allow a trusted parameter "white list" through.
        def poll_params
          params.require(:poll).permit(:heading, :sub_heading, :teaser, :description_heading, :description, :expires_at,
                                       :slug, :image_id, :background_image_id, :wallpaper_id, :category_id, :question,
                                       :order, :vote_options_attributes => [:text, :graph_rgb, :alias, :_destroy])
        end
      end
    end
  end
end
