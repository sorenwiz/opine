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
        @poll = Poll.find(params[:id])

        @vote_options = @poll.vote_options.to_a
        @vote_counts = @poll.votes.group(:vote_option_id).count
        @graph_data = @vote_options.map do |vote_option|
          [vote_option.text, @vote_counts.fetch(vote_option.id, 0)]
        end
        @related_polls = Poll.active.where.not(id: @poll.id).first(3)
        @page_title = @poll.heading
        @user_vote = Vote.find_by(user_id: current_user.id, poll_id: @poll.id) if user_signed_in?

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
