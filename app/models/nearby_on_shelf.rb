class NearbyOnShelf
  attr_reader :item_display, :barcode, :per, :page, :search_service
  delegate :shelfkey, :reverse_shelfkey, to: :current_callnumber

  def initialize(item_display:, barcode:, per: 24, page: 0, search_service:)
    @item_display = Array(item_display)
    @barcode = barcode
    @per = per
    @page = page
    @search_service = search_service
  end

  def document_list
    return [] unless current_callnumber

    # De-dup the list of items since duplicate records in the browse view
    # breaks the preview feature and we're pretty sure showing the same
    # record more than once isn't helpful.
    get_nearby_items.uniq { |i| i[:doc]['id'] }.map { |i| SolrDocument.new(i[:doc]) }
  end

  private

  def get_nearby_items
    if page == 0
      # get preceding bookspines
      get_preceding_spines_from_field +
        # multiple bib records can have the same shelfkey, so we need to
        # query solr to get all (some?) of them before looking at the
        # other shelfkeys.
        get_spines_from_field_values("shelfkey", [shelfkey]) +
        # get following bookspines
        get_following_spines_from_field
    elsif page < 0 # page is negative so we need to get the preceding docs
      get_preceding_spines_from_field
    elsif page > 0 # page is positive, so we need to get the following bookspines
      get_following_spines_from_field
    end
  end

  def get_preceding_spines_from_field
    get_next_spines_from_field(reverse_shelfkey, 'reverse_shelfkey')
  end

  def get_following_spines_from_field
    get_next_spines_from_field(shelfkey, 'shelfkey')
  end

  # given a shelfkey or reverse shelfkey (for a lopped call number), get the
  #  text for the next window of nearby items
  def get_next_spines_from_field(starting_value, field_name)
    number_of_shelfkeys_to_request = per * page.abs + (per / 2).floor

    desired_values = get_next_terms(starting_value, field_name, number_of_shelfkeys_to_request).keys

    # perform client-side windowing to get the desired number of items
    # because the solr terms component will include everything between the current
    # item and the last item needed for the range
    desired_values = desired_values.last(per) unless page == 0

    get_spines_from_field_values(field_name, desired_values)
  end

  # create an array of sorted html list items containing the appropriate display text
  #  (analogous to what would be visible if you were looking at the spine of
  #  a book on a shelf) from relevant solr docs, given a particular solr
  #  field and value for which to retrieve spine info.
  # Each html list item must match a desired value
  def get_spines_from_field_values(field, desired_values)
    # Get the documents for a set of shelf keys
    response, docs = search_service.search_results do |builder|
      builder.where(field => desired_values.compact)
    end

    spines = docs.flat_map do |doc|
      get_spines_from_doc(doc, field, desired_values.compact)
    end

    spines.uniq { |spine| spine[:sort_key] }.sort_by { |spine| spine[:sort_key] }
  end

  # create a hash with
  #     key = sorting key for the spine,
  #     value = the html list item containing appropriate display text
  #  (analogous to what would be visible if you were looking at the spine of
  #  a book on a shelf) from a solr doc.
  #   spine is:  <li> title [(pub year)] [<br/> author] <br/> callnum </li>
  # Each element of the hash must match a desired value in the
  #   desired_values array for the indicated piece (shelfkey or reverse shelfkey)
  def get_spines_from_doc(doc, field, desired_values)
    return [] if doc[:item_display].nil?

    # This winnows down the holdings hashs on only ones where the desired values includes the shelfkey or reverse shelfkey using a very quick select statment
    # The resulting array looke like [[:"36105123456789",{:barcode=>"36105123456789",:callnumber=>"PS3156 .A53"}]]
    item_array = doc.holdings.callnumbers.select do |callnumber|
      desired_values.include?(callnumber.send(field))
    end

    # looping through the resulting temp hash of holdings to build proper sort keys and then return a hash that conains a solr document for every item in the hash
    item_array.map do |callnumber|
      # create sorting key for spine
      # shelfkey asc, then by sorting title asc, then by pub date desc
      # notice that shelfkey and sort_title need to be a constant length
      #  separator of " -|- " is for human readability only
      sort_key = "#{callnumber.shelfkey[0, 100].ljust(100)} -|- "
      sort_key << "#{doc[:title_sort][0, 100].ljust(100)} -|- " unless doc[:title_sort].nil?

      # pub_year must be inverted for descending sort
      if doc[:pub_date].nil? || doc[:pub_date].length == 0
        sort_key << '9999'
      else
        sort_key << doc[:pub_date].tr('0123456789', '9876543210')
      end
      # Adding ckey to sort to make sure we collapse things that have the same callnumber, title, pub date, AND ckey
      sort_key << " -|- #{doc[:id][0, 20].ljust(20)}"
      # We were adding the library to the sortkey. However; if we don't add the library we can easily collapse items that have the same
      # call number (shelfkey), title, pub date, and ckey but are housed in different libraries.
      #sort_key << " -|- #{value[:library][0,40].ljust(40)}"

      { doc: doc.to_h, holding: callnumber, sort_key: sort_key }
    end  # end each item display
  end

  def get_next_terms(field, curr_value, how_many)
    # TermsComponent Query to get the terms
    solr_params = {
      'terms.fl' => field,
      'terms.lower' => curr_value,
      'terms.lower.incl' => false,
      'terms.sort' => 'index',
      'terms.limit' => how_many,
      'json.nl' => 'map'
    }

    solr_response = Blacklight.default_index.connection.alphaTerms({ params: solr_params })

    solr_response.dig('terms', field) || {}
  end

  def current_callnumber
    return if barcode.blank?

    @current_callnumber ||= begin
      callnumbers = item_display.map { |item| Holdings::Callnumber.new(item) }

      callnumbers.find { |callnumber| callnumber.barcode.starts_with?(barcode) }
    end
  end
end
