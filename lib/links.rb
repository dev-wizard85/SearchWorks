module SearchWorks
  class Links
    delegate :present?, :first, :last, :each, :map, :select, :find, to: :all
    def initialize(document)
      @document = document
    end
    def all
      []
    end

    def fulltext
      all.select(&:fulltext?).reject(&:finding_aid?)
    end

    def supplemental
      all.reject(&:fulltext?).reject(&:finding_aid?)
    end

    def finding_aid
      all.select(&:finding_aid?)
    end

    def sfx
      all.select(&:sfx?)
    end

    class Link
      attr_accessor :text
      def initialize(options={})
        @text = options[:text]
        @fulltext = options[:fulltext]
        @stanford_only = options[:stanford_only]
        @finding_aid = options[:finding_aid]
        @sfx = options[:sfx]
      end
      def ==(other)
        [@text, @fulltext, @stanford_only, @finding_aid, @sfx] == [other.text, other.fulltext?, other.stanford_only?, other.finding_aid?, other.sfx?]
      end
      def fulltext?
        @fulltext
      end
      def stanford_only?
        @stanford_only
      end
      def finding_aid?
        @finding_aid
      end
      def sfx?
        @sfx
      end
    end
  end
end
