require 'rubygems'
require 'rake'
require 'less'
require 'coffee-script'
require 'pp'

ROOT_PATH = File.expand_path('..',__FILE__)
SRC_PATH = File.join(ROOT_PATH, 'src')
COMPILED_PATH = File.join(ROOT_PATH, 'compiled')


def files(src, out)
  Dir[File.join(SRC_PATH, src, "*.#{src}")].map do |f|
    s = File.basename(f).gsub(/\.#{src}$/, ".#{out}")
    [f, File.join(COMPILED_PATH, out, s)]
  end
end

task :default => [:coffee, :lessc]

desc "Compile coffeescript"
task :coffee do
  files('coffee', 'js').each do |(source, destination)|
    source_file = File.read(source)
    dest_file = File.open(destination, 'w+')
    dest_file.write CoffeeScript.compile(source_file)
  end
end

desc "Compile Less"
task :lessc do
  files('less', 'css').each do |(source, destination)|
    source_file = File.read(source)
    dest_file = File.open(destination, 'w+')
    dest_file.write Less::Parser.new.parse(source_file).to_css
  end
end # task :lessc