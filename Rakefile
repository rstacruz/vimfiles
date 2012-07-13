x = lambda { |str| File.expand_path str }
require 'fileutils'

task :setup => [
  :'setup:check',    # Ensure we're in ~/.vim
  :'setup:vimrc',    # Make a symlink to ~/.vimrc
  :'setup:vundle',   # Set up the Git repo for Vundle
  :'build',          # Build things (like Command T)
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

  task :vundle do
    if File.exists?("./bundle/vundle")
      status "(Skipping Vundle checkout, you already have it.)"
    else
      status "Installing Vundle..."
      FileUtils.mkdir_p "./bundle"
      system "git clone http://github.com/gmarik/vundle.git bundle/vundle"
    end

    status "Spawning Vim to install bundles..."
    system "vim -u vimrc.vim +BundleInstall +q +q"
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
  cmds = []
  Dir['./bundle/*'].each do |bundle_path|
    Dir.chdir bundle_path do
      url = get_origin_url
      cmds << "git submodule add #{url} #{bundle_path}"
    end
  end
  script = cmds.join("\n")
  File.open('script.sh', 'w') { |f| f.write script }
  system "bash script.sh"
  FileUtils.rm "script.sh"
end

# ============================================================================

namespace :build do
  task :command_t do
    system "which rvm >/dev/null && rvm use system; cd bundle/Command-T/ruby/command-t && ruby extconf.rb && make"
  end
end

# ============================================================================

desc "Builds all things that needs building"
task :build => [:'build:command_t']
