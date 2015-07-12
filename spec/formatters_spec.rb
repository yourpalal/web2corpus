require 'rspec'
require 'stringio'

require 'crawl'
require 'formatters'

require 'test_construct'

doc1 = "This is a document\nwith a newline"
doc2 = "This is another document"
root = 'http://example.com/wow/'

RSpec.describe LinePrinter, '#append' do
  it 'prints one line per document' do
    result = StringIO::open do |out|
      LinePrinter.new(out)
        .append(doc1, "#{root}index.html")
        .append(doc2, "#{root}/cool/index.html")

      out.string
    end

    expect(result.lines.length).to eq(2)
    expect(result.lines[1]).to eq(doc2)
  end
end


RSpec.describe FilePrinter, '#append' do
  include TestConstruct::Helpers

  it 'prints one file per document' do
    crawl = Crawl.new root
    folder = 'test_output/'

    within_construct() do |construct|
      construct.directory 'fileprinter_web2text' do |d|
        FilePrinter.new(crawl, folder)
          .append(doc1, "#{root}index.html")
          .append(doc2, "#{root}/cool/index.html")

        doc1_path = File.join folder, 'index.html'
        expect(File::file?(doc1_path)).to be_truthy
        expect(IO.read(doc1_path)).to eq(doc1)

        doc2_path = File.join(folder, 'cool', 'index.html')
        expect(File.file?(doc2_path)).to be_truthy
        expect(IO.read(doc2_path)).to eq(doc2)
      end
    end
  end
end
