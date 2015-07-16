require 'nokogiri'

require_relative '../lib/crawler'

RSpec.describe Crawler, '#process_doc' do
  before(:all) do
    @root = "http://example.com"
    @crawl = Crawl.new @root

    @h1_content = "This is a document"
    @p_content = "good stuff!"

    @example_html = Nokogiri::HTML "<!doctype html><html><head></head><body><h1>#{@h1_content}</h1><p>#{@p_content}</p></body></html>"
  end

  before(:each) do
    @crawler = Crawler.new @crawl
  end

  it 'can consider a page and make output' do
    out = @crawler.doc_as_plaintext @example_html
    expect(out).to eq "#{@h1_content} #{@p_content}"
  end

  it 'can limit the output by using css queries' do
    tests = [
      ["p", @p_content],
      ["h1", @h1_content],
      ["p, h1", "#{@h1_content} #{@p_content}"],
      ["h1, p", "#{@h1_content} #{@p_content}"]
    ]

    tests.each do |test|
      @crawler = Crawler.new @crawl, test[0]
      out = @crawler.doc_as_plaintext @example_html
      expect(out).to eq(test[1]), "with css query '#{test[0]}', got '#{out}', but expected '#{test[1]}'"
    end
  end
end
