#!/usr/bin/env ruby
require 'yaml'
require 'fileutils'

options = {
  :ignore => [ 'install.yml', File.basename($0) ],
  :path   => ENV['HOME'],
  :dot    => [ '*' ],
  :files  => [ '*' ]
}

def say_status(what, status, priority=0)
  color = 32
  color = 31  if priority == 1
  status.gsub!(ENV['HOME'], '~')
  status += "/"  if File.directory?(File.expand_path(status))
  puts "\033[1;#{color}m%10s\033[0m  %s" % [what, status]
end

def work!(options)
  ignores    = options[:ignore].map { |spec| Dir[spec] }.flatten
  dots       = options[:dot].map { |spec| Dir[spec] }.flatten
  files      = options[:files]

  unless options[:uninstall]
    puts "Installing to #{options[:path]}..."
  else
    puts "Uninstalling from #{options[:path]}..."
  end

  files.each do |spec|
    Dir[spec].each do |infile|
      next  if ignores.include?(infile)

      fname   = dots.include?(infile) ? ".#{infile}" : infile
      outfile = File.join(options[:path], fname)
      outdir  = File.dirname(outfile)

      # If uninstalling...
      if options[:uninstall]
        if File.symlink?(outfile)
          File.unlink outfile  unless options[:simulate]
          say_status :unlink, outfile
        end
        next
      end

      # Do nothing if the file already exists
      if File.exists?(outfile) and (!File.symlink?(outfile))
        say_status :exists, outfile, 1
        next
      end

      # Create the folder if it doesn't exist
      unless File.directory?(outdir)
        FileUtils.mkdir_p outdir  unless options[:simulate]
        say_status :mkdir, outdir
      end

      # Delete the symlink if it exists
      status = :symlink
      if File.symlink?(outfile)
        File.unlink outfile  unless options[:simulate]
        status = :update
      end

      # Create the symlink
      FileUtils.ln_s File.expand_path(infile), File.expand_path(outfile)  unless options[:simulate]
      say_status status, outfile
    end
  end
end

if ["-help", "--help", "-h", "-?"].include?(ARGV.join(''))
  puts "Usage:"
  puts "  #{$0}     # Install"
  puts "  #{$0} -s  # Simulate install"
  puts "  #{$0} -u  # Uninstall"
  exit
end

options.merge! YAML::load_file('install.yml')  if File.exists?('install.yml')
options[:simulate]  = true  if ARGV.include?('-s')
options[:uninstall] = true  if ARGV.include?('-u')
work! options  if $0 == __FILE__
