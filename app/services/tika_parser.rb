require 'open3'

class TikaParser
  def initialize(filename)
    @filename = filename
    to_hash
  end

  def tika_path
    Rails.root.join('vendor/java/tika-app-1.4.jar')
  end

  def output format = :text
    format_argument = format == :html ? "-h" : "-t"
    stdout, errors, _ = Open3.capture3 "java -jar #{tika_path} #{format_argument} #{@filename}"
    stdout
  end

  def title
    output.lines.detect { |l| l.present? }.strip
  end

  def body
    elements = Nokogiri::HTML(output :html).css('body').children
    non_blank_elements = elements.reject { |e| e.inner_text.blank? }
    Nokogiri::XML::NodeSet.new(elements.document, non_blank_elements[1..-1]).to_html.strip
  end

  def to_hash
    { title: title, body: body }
  end

  class << self
    def parse(filename)
      new(filename).to_hash
    end
  end
end
