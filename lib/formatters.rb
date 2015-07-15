require 'uri'

class LinePrinter
  def initialize(crawl, output)
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

  def close
    @output.close
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
    if path.extname == "" then
      path = path + 'index.txt'
    end

    path = path.sub_ext('.txt')

    path.parent.mkpath
    path.open("w") { |f| f.write(doc) }
    self
  end

  def close
  end
end
