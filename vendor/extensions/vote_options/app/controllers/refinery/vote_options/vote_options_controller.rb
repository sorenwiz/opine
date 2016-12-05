module Refinery
  module VoteOptions
    class VoteOptionsController < ::ApplicationController

      before_action :find_all_vote_options
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @vote_option in the line below:
        present(@page)
      end

      def show
        @vote_option = VoteOption.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @vote_option in the line below:
        present(@page)
      end

    protected

      def find_all_vote_options
        @vote_options = VoteOption.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/vote_options").first
      end

    end
  end
end
