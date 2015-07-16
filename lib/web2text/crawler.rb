
class Web2Text::Crawler
  def initialize(crawl, query="body")
    @crawl = crawl
    @query = query
  end

  def doc_as_plaintext(doc)
    # just using inner_text doesn't give us quite enough spaces :(
    doc.css(@query).collect do |j|
      bits = []
      j.traverse do |c|
        if c.text? then bits.push c.content end
      end

      bits.join(' ')
    end.join(' ')
  end
end
