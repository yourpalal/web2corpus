require 'crawl'

root = "http://example.com"

RSpec.describe Crawl, '#filter' do
  context "with no patterns" do
    it "returns all links" do
      crawl = Crawl.new root
      links = ["#{root}/wow", "#{root}/neat"]
      expect(crawl.filter links).to eq links
    end
  end

  context "with patterns" do
    it "can filter out whole directories" do
      good = ["#{root}/wow", "#{root}/neat"]
      bad = ["#{root}/avoid", "#{root}/avoid/index.html", "#{root}/avoid/this/nested/stuff"]

      crawl = Crawl.new root, ["#{root}/avoid"]
      expect(crawl.filter good + bad).to eq good
    end

    it "can skip host name parts to filter out directories" do
      good = ["#{root}/wow", "#{root}/neat"]
      bad = ["#{root}/avoid", "#{root}/avoid/index.html", "#{root}/avoid/this/nested/stuff"]

      crawl = Crawl.new root, ["/avoid"]
      expect(crawl.filter good + bad).to eq good
    end
  end
end
