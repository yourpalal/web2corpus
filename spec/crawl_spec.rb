require_relative '../lib/crawl'

root = "http://example.com"

RSpec.describe Crawl, '#filter' do
  context "with no patterns" do
    it "returns all links" do
      crawl = Crawl.new root
      links = ["#{root}/wow", "#{root}/neat"]
      expect(crawl.filter links).to eq links
      expect(links.select {|u| crawl.focus? u}).to eq links
    end

    it "will not crawl above the root" do
      crawl = Crawl.new "#{root}/wow/cool"
      expect(crawl.skip? root).to be true
    end
  end

  context "with patterns" do
    it "can filter out whole directories" do
      good = ["#{root}/wow", "#{root}/neat"]
      bad = ["#{root}/avoid", "#{root}/avoid/index.html", "#{root}/avoid/this/nested/stuff"]

      crawl = Crawl.new root, ["#{root}/avoid"]
      expect(crawl.filter good + bad).to eq good
    end

    it "can focus on pages" do
      bad = ["#{root}/avoid", "#{root}/avoid"]
      good = ["#{root}/focus", "#{root}/focus/index.html", "#{root}/focus/this/nested/stuff"]

      crawl = Crawl.new root, [], ["#{root}/focus"]
      expect((good + bad).select {|u| crawl.focus? u}).to eq good
    end

    it "can skip host name parts to filter out directories" do
      good = ["#{root}/wow", "#{root}/neat"]
      bad = ["#{root}/avoid", "#{root}/avoid/index.html", "#{root}/avoid/this/nested/stuff"]

      crawl = Crawl.new root, ["/avoid"]
      expect(crawl.filter good + bad).to eq good
    end
  end
end
