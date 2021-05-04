module MarcHelper
  def render_if_present(renderable)
    render renderable if renderable.present?
  end

  def get_data_with_label_from_marc(marc, label, tag, opts = {})
    linking_fields = %W(506 510 514 520 530 538 540 542 545 552 555 561 563 583 590)
    fields = []
    if marc[tag] or (Constants::NIELSEN_TAGS.has_key?(tag) and marc[Constants::NIELSEN_TAGS[tag]])
      label = "Publisher's Summary" if Constants::NIELSEN_TAGS.has_key?(tag) and marc[Constants::NIELSEN_TAGS[tag]] and tag == "520"
      tag = Constants::NIELSEN_TAGS[tag] if Constants::NIELSEN_TAGS.has_key?(tag) and marc[Constants::NIELSEN_TAGS[tag]]
      marc.find_all { |f| (tag) === f.tag }.each do |field|
        field_text = ""
        unless (Constants::HIDE_1ST_IND.include?(tag) and field.indicator1 == "1") or (Constants::HIDE_1ST_IND0.include?(tag) and field.indicator1 == "0")
          if opts[:sub_fields] and opts[:sub_fields].length > 0
            field.each do |sub_field|
              field_text << "#{sub_field.value} " if opts[:sub_fields].include?(sub_field.code)
            end
          else
            field.each do |sub_field|
              if tag == "590" and sub_field.code == "c"
                ckey = sub_field.value[/^(\d+)/]
                ckey_link = link_to(ckey, url_for(ckey))
                field_text << "#{sub_field.value.gsub(ckey, ckey_link)} " unless (ckey.nil? or ckey_link.nil?)
                field_text = field_text.html_safe
              elsif linking_fields.include?(tag) and sub_field.code == "u" and sub_field.value.strip =~ /^https*:\/\//
                field_text << "#{link_to(sub_field.value, sub_field.value)} "
                field_text = field_text.html_safe
              elsif sub_field.code == "1" and Constants::NIELSEN_TAGS.has_value?(tag)
                field_text << "<br/><span class='source'>#{Constants::SOURCES[sub_field.value]}</span>"
                field_text = field_text.html_safe
              elsif !Constants::EXCLUDE_FIELDS.include?(sub_field.code)
                field_text << "#{sub_field.value} " unless (sub_field.code == 'a' and sub_field.value[0, 1] == "%")
              end
            end
          end
          fields << { field: field_text, vernacular: get_marc_vernacular(marc, field) } unless field_text.blank?
        end
      end
    else
      unmatched_vern = get_unmatched_vernacular(marc, tag)
    end
    return { label: label, fields: fields, unmatched_vernacular: unmatched_vern } unless (fields.empty? and unmatched_vern.nil?)
  end

  def link_to_included_works_from_marc(marc)
    contributors_and_works_from_marc(marc)[:included_works]
  end

  def contributors_and_works_from_marc(marc)
    vern_text = ""
    included_works = []
    contributors = []
    ['700', '710', '711', '720'].each do |tag|
      if marc[tag]
        marc.find_all { |f| (tag) === f.tag }.each do |field|
          if !field["t"].blank?
            next unless field.indicator2 == "2"

            subt = :none
            link_text = []
            extra_text = []
            before_text = []
            href_text = []
            extra_href = []
            field.each do |subfield|
              next if Constants::EXCLUDE_FIELDS.include?(subfield.code)

              # $e $i $4
              if subfield.code == "t"
                subt = :now
              end
              if subfield.code == "i" and subt == :none # assumes $i at beginning
                before_text << subfield.value.gsub(/\s*\(.+\)\s*/, '')
              elsif subt == :none
                href_text << subfield.value unless ["e", "i", "j", "4"].include?(subfield.code)
                link_text << subfield.value
              elsif subt == :now or (subt == :passed and subfield.value.strip =~ /[\.|;]$/)
                href_text << subfield.value unless ["e", "i", "j", "4"].include?(subfield.code)
                link_text << subfield.value
                subt = :passed
                subt = :done if subfield.value.strip =~ /[\.|;]$/
              elsif subt == :done
                extra_href << subfield.value unless ["e", "i", "j", "4"].include?(subfield.code)
                extra_text << subfield.value
              else
                href_text << subfield.value unless ["e", "i", "j", "4"].include?(subfield.code)
                link_text << subfield.value
              end
            end
            href = "\"#{href_text.join(" ")}\""
            link = ""
            link << "#{before_text.join(" ")} " unless before_text.blank?
            link << link_to(link_text.join(" "), search_catalog_path(q: href, search_field: 'author_title'))
            link << " #{extra_text.join(" ")}" unless extra_text.blank?
            included_works << link
          else
            link_text = ""
            temp_text = ""
            relator_text = []
            extra_text = ""
            field.each do |subfield|
              next if Constants::EXCLUDE_FIELDS.include?(subfield.code)

              if subfield.code == "e"
                relator_text << subfield.value
              elsif subfield.code == "4" and relator_text.blank?
                relator_text << Constants::RELATOR_TERMS[subfield.value]
              elsif tag == '711' && subfield.code == 'j'
                extra_text << "#{subfield.value} "
              elsif subfield.code != "e" and subfield.code != "4"
                link_text << "#{subfield.value} "
              end
            end
            temp_text << link_to(link_text.strip, search_catalog_path(q: "\"#{link_text}\"", search_field: 'search_author'))
            temp_text << " #{relator_text.join(" ")}" unless relator_text.blank?
            temp_text << " #{extra_text} " unless extra_text.blank?
            vernacular = get_marc_vernacular(marc, field)
            temp_vern = "\"#{vernacular}\""
            temp_text << "<br/>#{link_to h(vernacular), search_catalog_path(q: temp_vern, search_field: 'search_author')}" unless vernacular.nil?
            contributors << temp_text
          end
        end
      else
        if marc['880']
          marc.find_all { |f| ('880') === f.tag }.each do |field|
            if !field['6'].nil? and field['6'].include?("-")
              if field['6'].split("-")[1].gsub("//r", "") == "00" and field['6'].split("-")[0] == tag
                vern_text = "<dt>Contributor</dt><dd>"
                  link_text = ''
                  relator_text = ""
                  field.each do |subfield|
                    if subfield.code == "e"
                      relator_text = Constants::RELATOR_TERMS[subfield.value]
                    elsif subfield.code == "4" and relator_text.blank?
                      relator_text = Constants::RELATOR_TERMS[subfield.value]
                    elsif subfield.code == "6"
                      nil
                    elsif subfield.code != "e" and subfield.code != "4"
                      link_text << "#{subfield.value} "
                    end
                  end
                  vern_text << link_to(h(link_text.strip), q: "\"#{link_text}\"", action: 'index', search_field: 'author_search')
                  vern_text << relator_text unless relator_text.blank?
                  vern_text << "</dd>"
              end
            end
          end
        end
      end
    end
    return_hash = {}
    return_hash[:contributors] = "<dt>Contributor</dt><dd>#{contributors.join('</dd><dd>')}</dd>".html_safe unless contributors.blank?
    return_hash[:contributors] = "#{return_hash[:contributors]} #{vern_text}".html_safe unless vern_text.blank?
    return_hash[:included_works] = "<dt>Included Work</dt><dd>#{included_works.join('</dd><dd>')}</dd>".html_safe unless included_works.blank?
    return_hash
  end

  def get_marc_vernacular(marc, field)
    return_text = []
    if field['6']
      field_original = field.tag
      match_original = field['6'].split("-")[1]
      marc.find_all { |f| ('880') === f.tag }.each do |field|
        if !field['6'].nil? and field['6'].include?("-")
          field_880 = field['6'].split("-")[0]
          match_880 = field['6'].split("-")[1].gsub("//r", "")
          if match_original == match_880 and field_original == field_880
            field.each do |sub|
              next if Constants::EXCLUDE_FIELDS.include?(sub.code) || sub.code == '4'

              return_text << sub.value
            end
          end
        end
      end
    end
    return return_text.join(" ") unless return_text.blank?
  end

  def get_unmatched_vernacular(marc, tag)
    fields = []
    if marc['880']
      marc.find_all { |f| ('880') === f.tag }.each do |field|
        text = ""
        unless field['6'].nil? or !field["6"].include?("-")
          if field['6'].split("-")[1].gsub("//r", "") == "00" and field['6'].split("-")[0] == tag
            field.each { |sub_field| Constants::EXCLUDE_FIELDS.include?(sub_field.code) ? nil : text << "#{sub_field.value} " }
          end
        end
        fields << text.strip unless text.blank?
      end
    end
    return fields unless fields.empty?
  end

  def get_unmatched_vernacular_fields(marc, tag)
    fields = []
    if marc['880']
      marc.find_all { |f| ('880') === f.tag }.each do |field|
        unless field['6'].nil? or !field["6"].include?("-")
          if field['6'].split("-")[1].gsub("//r", "") == "00" and field['6'].split("-")[0] == tag
            fields << field
          end
        end
      end
    end
    return fields unless fields.blank?
  end

  # Generate hierarchical structure of subject headings from marc
  def get_subjects(document)
    subs = ['600', '610', '611', '630', '650', '651', '653', '654', '656', '657', '658', '691', '693', '696', '697', '698', '699']
    get_subjects_hierarchy('Subject', get_subjects_array(document, subs))
  end

  # Generate hierarchical structure of subject headings from marc
  def get_genre_subjects(document)
    get_subjects_hierarchy('Genre', get_subjects_array(document, ['655']))
  end

  def get_local_subjects(document)
    get_subjects_hierarchy('Local subject', get_subjects_array(document, ['690']))
  end

  def get_subjects_hierarchy(label, subjects)
    text = "<dt>#{label}</dt>".html_safe
    unless subjects.blank?
      subjects.each_with_index do |fields, i|
        text << "<dd>".html_safe
        link_text = ""
        title_text = "Search: "
        fields.each do |field|
          link_text << " " unless field == subjects[i].first
          link_text << field.strip
          title_text << " - " unless field == subjects[i].first
          title_text << "#{field.strip}"
          text << link_to(field.strip, search_catalog_path(q: "\"#{link_text}\"", search_field: 'subject_terms'), title: title_text)
          text << " &gt; ".html_safe unless field == subjects[i].last
        end
        text << "</dd>".html_safe
      end
    end
    return text unless text == "<dt>#{label}</dt>"
  end

  def get_subjects_array(document, subs)
    document.subjects(subs).values
  end

  def results_imprint_string(document)
    document.fetch(:imprint_display, []).first
  end

  def get_uniform_title(doc)
    return unless doc['uniform_title_display_struct']

    data = doc['uniform_title_display_struct'].first
    field_data = data[:fields].first[:field]

    search_field = if %w(130 730).include?(data[:uniform_title_tag])
                     'search_title'
                   else
                     'author_title'
                   end
    vern = data[:fields].first[:vernacular][:vern]
    href = "\"#{[field_data[:author], field_data[:link_text]].join(' ')}\""
    {
      label: data[:label],
      unmatched_vernacular: data[:unmatched_vernacular],
      fields: [
        {
          field: "#{field_data[:pre_text]} #{link_to(field_data[:link_text], { action: 'index', controller: 'catalog', q: href, search_field: search_field })} #{field_data[:post_text]}".html_safe,
          vernacular: (link_to(vern, { q: "\"#{vern}\"", controller: 'catalog', action: 'index', search_field: search_field }) if vern)
        }
      ]
    }
  end

  def render_field_from_marc(fields, opts = {})
    render "catalog/field_from_marc", fields: fields, options: opts
  end
end
