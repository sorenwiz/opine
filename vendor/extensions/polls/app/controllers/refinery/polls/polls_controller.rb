module Refinery
  module Polls
    class PollsController < ::ApplicationController

      before_action :find_all_polls
      before_action :find_page

      def index
        @polls = @polls.to_a
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @poll in the line below:
        present(@page)
      end

      def show
        @poll = Poll.where(id: params[:id]).first
        raise ActionController::RoutingError.new('Not Found') unless @poll.present?

        @vote_options = @poll.vote_options.to_a

        @vote_counts = @poll.votes.group(:vote_option_id).count

        @graph_data = @vote_options.map do |vote_option|
          [vote_option.translation.text, @vote_counts.fetch(vote_option.id, 0), prepare_rgb_to_js(vote_option.graph_rgb), vote_option.translation.alias]
        end

        @graph_data.sort! {|first, last| last[1] <=> first[1] }

        @related_polls = Poll.active
                             .with_locale(params[:locale].to_s)
                             .order('"order" ASC')
                             .where
                             .not(id: @poll.id).first(3)

        @page_title = @poll.heading
        @user_vote = Vote.find_by(user_id: current_user.id, poll_id: @poll.id) if user_signed_in?
        @wallpaper = @poll.wallpaper.url if @poll.wallpaper_id.present?

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @poll in the line below:
        present(@page)
      end

      protected

      def find_all_polls
        @polls = Poll.active
                     .with_locale(params[:locale].to_s)
                     .order('"order" ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/polls").first
      end

      private

      def prepare_rgb_to_js(value)

        result = '"rgba(90,220,150, 0.5)"'
        if value
          check = value.strip.match /\A\d{1,3},\d{1,3},\d{1,3}\z/
          result = "\"rgba(#{check}, 0.5)\"" if check
        end

        result
      end
    end
  end
end
