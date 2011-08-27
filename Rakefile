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

namespace :setup do
  task :check do
    if File.basename(Dir.pwd) != '.vim'
      puts "Note: This repo must be cloned into ~/.vim."
      exit
    end
  end

  task :vimrc do
    if File.exists?(x['~/.vimrc'])
      fn = "~/.vimrc.#{Time.now.to_i.to_s}"
      puts "* Moving aside your .vimrc to #{fn}..."
      FileUtils.mv x["~/.vimrc"], x[fn]
    end

    puts "* Installing ~./vimrc..."
    FileUtils.ln_s "#{Dir.pwd}/vimrc.vim", x["~/.vimrc"]
  end

  task :vundle do
    if File.exists?("./bundle/vundle")
      puts " * (Skipping Vundle checkout, you already have it.)"
    else
      puts " * Installing Vundle..."
      FileUtils.mkdir_p "./bundle"
      system "git clone http://github.com/gmarik/vundle.git bundle/vundle"
    end

    puts " * Spawning Vim to install bundles..."
    system "vim -u vimrc.vim +BundleInstall +q +q"
  end

  task :_after do
    puts ""
    puts "OK! Hooray!"
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

namespace :build do
  task :command_t do
    system "which rvm >/dev/null && rvm use system; cd bundle/Command-T/ruby/command-t && ruby extconf.rb && make"
  end
end

# ============================================================================

desc "Builds all things that needs building"
task :build => [:'build:command_t']
