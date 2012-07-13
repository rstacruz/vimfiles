x = lambda { |str| File.expand_path str }
require 'fileutils'

task :setup => [
  :'setup:check',    # Ensure we're in ~/.vim
  :'setup:vimrc',    # Make a symlink to ~/.vimrc
  :'setup:_after'
]

# ============================================================================

def status(str)
  puts "\033[0;34m==>\033[0;32m #{str}\033[0;m"
end

namespace :setup do
  task :check do
    if File.basename(Dir.pwd) != '.vim'
      status "Note: This repo must be cloned into ~/.vim."
      exit
    end
  end

  task :vimrc do
    if File.exists?(x['~/.vimrc'])
      fn = "~/.vimrc.#{Time.now.to_i.to_s}"
      status "Moving aside your .vimrc to #{fn}..."
      FileUtils.mv x["~/.vimrc"], x[fn]
    end

    status "Installing ~./vimrc..."
    FileUtils.ln_s "#{Dir.pwd}/vimrc.vim", x["~/.vimrc"]
  end

  task :_after do
    puts ""
    status "OK! Hooray!"
  end
end

# ============================================================================

desc "Make the sass snippets"
task :sass do
  str = File.read('UltiSnips/css.snippets')
  str.gsub!(/;/, '')
  str.gsub!(/ \{$/, '')
  str.gsub!(/^\}$/, '')
  str.gsub!('@include ', '+')

  puts "+ UltiSnips/sass.snippets"
  File.open('UltiSnips/sass.snippets', 'w') { |f| f.write str }
end

# ============================================================================

def get_origin_url
  output = `git remote -v`.split("\n")
  line = output.select { |line| line =~ /^origin\t/ }.first
  return unless line
  line.split("\t")[1].split(' ')[0]
end

desc "Add bundles installed by Vundle into submodules."
task :'submodule:sync' do
  require 'fileutils'
  lines = []
  Dir['./bundle/*'].each do |bundle_path|
    Dir.chdir bundle_path do
      url = get_origin_url
      lines << %<[submodule "#{bundle_path}"]>
      lines << %<  path = #{bundle_path}>
      lines << %<  url = #{url}>
    end
  end
  script = lines.join("\n") + "\n"
  File.open('.gitmodules', 'w') { |f| f.write script }
end
