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
