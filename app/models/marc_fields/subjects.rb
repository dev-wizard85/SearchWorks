# frozen_string_literal: true

class Subjects < MarcField
  def values
    @values ||= begin
      data = []
      extracted_fields.each do |field, subfields|
        if repeating_subfield_a?(field, subfields)
          data += subfields.select { |sf| sf.code == 'a' && !ignored_subfield_a_value?(sf) }.map { |sf| [sf.value] }
          data << subfields.select { |sf| ["v", "x", "y", "z"].include?(sf.code) }.map(&:value)
        else
          arr = subfields.reject { |sf| ignored_subfield?(sf) || ignored_subfield_a_value?(sf) }.slice_before { |v| %w(a v x y z).include? v.code }.map do |group|
            group.map(&:value).flatten.compact.join(' ')
          end

          data << arr
        end
      end

      data.uniq.reject(&:blank?)
    end
  end

  def repeating_subfield_a?(_field, subfields)
    subfields.count { |sf| sf.code == 'a' && !ignored_subfield_a_value?(sf) } > 1
  end

  def ignored_subfield_a_value?(subfield)
    return false unless subfield.code == 'a'

    subfield.value[0, 1] == "%" || subfield.value.starts_with?('nomesh')
  end

  def ignored_subfield?(subfield)
    exclude = Constants::EXCLUDE_FIELDS.dup + ["1", "2", "3", "4", "7", "9"]

    exclude.include? subfield.code
  end

  def to_partial_path
    'marc_fields/subjects'
  end
end
