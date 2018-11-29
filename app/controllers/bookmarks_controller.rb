# frozen_string_literal: true

class BookmarksController < CatalogController
  include Blacklight::Bookmarks
  include SelectionsCount

  # Overidden from Blacklight to add our tabbed interface
  def index
    @bookmarks = token_or_current_or_guest_user.bookmarks.where(record_type: 'catalog')
    bookmark_ids = @bookmarks.collect { |b| b.document_id.to_s }

    @response, @document_list = fetch(bookmark_ids)

    @catalog_count = selections_counts.catalog
    @article_count = selections_counts.articles

    respond_to do |format|
      format.html {}
      format.rss  { render layout: false }
      format.atom { render layout: false }
      format.json do
        render json: render_search_results_as_json
      end

      additional_response_formats(format)
      document_export_formats(format)
    end
  end

  def clear
    if clear_bookmarks
      flash[:success] = I18n.t('blacklight.bookmarks.clear.success')
    else
      flash[:error] = I18n.t('blacklight.bookmarks.clear.failure')
    end
    redirect_back fallback_location: bookmarks_url
  end

  protected

  # Clears bookmarks from an ActiveRecord CollectionProxy
  # and deletes bookmarks from an AssociationRelation (and returns true)
  def clear_bookmarks
    return current_or_guest_user.bookmarks.clear unless clear_params[:type]

    # calling delete_all to be fast, I don't believe we care about callbacks in this case
    current_or_guest_user.bookmarks.where(record_type: clear_params[:type]).delete_all
    true # Returning true so this is viewed as a success
  end

  # Only permit a type param of articles or catalog
  def clear_params
    params.permit(:type).select { |_, val| %w[article catalog].include? val }
  end
end
