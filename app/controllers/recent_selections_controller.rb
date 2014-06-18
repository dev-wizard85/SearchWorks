class RecentSelectionsController < ApplicationController

  include Blacklight::SolrHelper
  include Blacklight::Catalog::SearchContext
  def index
    _, @recent_selections =
      get_solr_response_for_document_ids(
        current_or_guest_user.bookmarks.last(3).map(&:document_id)
      )
    if request.xhr?
      respond_to do |format|
        format.html do
          render recent_selections: @recent_selections, layout: false
        end
      end
    else
      redirect_to root_url
    end
  end
end
