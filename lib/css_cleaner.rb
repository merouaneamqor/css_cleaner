def parse_erb_haml
  pattern = /class=["']([^"']+)["']/
  Find.find('./') do |path|
    if path.include?('/node_modules/')
      Find.prune
    else
      next unless ['.erb', '.haml'].include?(File.extname(path)) && File.file?(path)
      File.open(path, 'r').each_line do |line|
        line.scan(pattern) do |match|
          @dynamic_classes.concat(match.first.split)
        end
      end
    end
  end
end

def parse_js_coffeescript
  pattern = /\.addClass\(["']([^"']+)["']\)/
  Find.find('./') do |path|
    if path.include?('/node_modules/')
      Find.prune
    else
      next unless ['.js', '.coffee'].include?(File.extname(path)) && File.file?(path)
      File.open(path, 'r').each_line do |line|
        line.scan(pattern) do |match|
          @dynamic_classes.concat(match.first.split)
        end
      end
    end
  end
end

def parse_css_scss
  pattern = /\.([^ ,:{]+)[ ,:{]/
  Find.find('./') do |path|
    if path.include?('/node_modules/')
      Find.prune
    else
      next unless ['.css', '.scss'].include?(File.extname(path)) && File.file?(path)
      File.open(path, 'r').each_line do |line|
        line.scan(pattern) do |match|
          @defined_classes << match.first
        end
      end
    end
  end
end
