require 'uri'

class Crawl
  def initialize(url, avoid = [])
    @url = url

    root_uri = URI(url)
    @avoid = avoid.map { |a|
      a = URI::join(url, a) if !a.start_with? url
      a.to_s
    }
  end

  def filter(urls)
    urls.reject {|u| self.skip? u}
  end

  def skip?(url)
      @avoid.any? { |a|
        url.start_with? a
      }
  end
end
