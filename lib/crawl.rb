require 'uri'

class Crawl
  attr_reader :url

  def initialize(url, avoid = [])
    @url = url

    @avoid = avoid.map { |a|
      a = URI::join(url, a) if !a.start_with? url
      a.to_s
    }
  end

  def filter(urls)
    urls.reject {|u| self.skip? u}
  end

  def skip?(url)
    url_s = url.to_s
    @avoid.any? { |a|
      url_s.start_with? a
    }
  end
end
