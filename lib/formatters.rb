require 'uri'

class LinePrinter
  def initialize(output)
    @output = output
    @first = true
  end

  def append(doc, uri)
    if !@first then
      @output.write "\n"
    end
    @first = false

    @output.write doc.gsub(/\n+/, ' ')
    self
  end
end

# Writes one file per page
class FilePrinter
  def initialize(crawl, out_dir)
    @crawl_root = Pathname(URI(crawl.url).path)
    @out_dir = Pathname(out_dir)
  end

  def append(doc, uri)
    path = @out_dir + Pathname(URI(uri).path).relative_path_from(@crawl_root)
    if path.basename == "" then
      path = path + 'index.html'
    end

    path.parent.mkpath
    path.open("w") { |f| f.write(doc) }
    self
  end
end
