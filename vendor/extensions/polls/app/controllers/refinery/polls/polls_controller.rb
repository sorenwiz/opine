module Refinery
  module Polls
    class PollsController < ::ApplicationController

      before_action :find_all_polls
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @poll in the line below:
        present(@page)
      end

      def show
        @poll = Poll.where(id: params[:id]).first
        raise ActionController::RoutingError.new('Not Found') unless @poll.present?

        @vote_options = @poll.vote_options.includes(:translation).to_a
        @vote_counts = @poll.votes.group(:vote_option_id).count

        @graph_data = @vote_options.map do |vote_option|
          [vote_option.translation.text, @vote_counts.fetch(vote_option.id, 0)]
        end

        @related_polls = Poll.active.where.not(id: @poll.id).first(3)
        @page_title = @poll.heading
        @user_vote = Vote.find_by(user_id: current_user.id, poll_id: @poll.id) if user_signed_in?
        @wallpaper = @poll.wallpaper.url if @poll.wallpaper_id.present?

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @poll in the line below:
        present(@page)
      end

    protected

      def find_all_polls
        @polls = Poll.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/polls").first
      end

    end
  end
end
