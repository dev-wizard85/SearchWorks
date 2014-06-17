module BrowseHelper
  def link_to_callnumber_browse(document, callnumber, data_attributes = {})
    link_to(
      callnumber.callnumber,
      browse_index_path(
        start: document[:id],
        barcode: (callnumber.barcode unless callnumber.barcode == document[:preferred_barcode]),
        view: :gallery
      ), data_attributes
    )
  end
end
