#!/usr/bin/env ruby

require 'yaml'
require 'fileutils'

options = {
  :ignore => [ 'install.*' ],
  :dot    => [ '*' ],
  :files  => [ '*' ]
}

def say_status(what, status)
  status.gsub!(ENV['HOME'], '~')
  puts "%10s  %s" % [what, status]
end

def work!(options)
  ignores    = options[:ignore].map { |spec| Dir[spec] }.flatten
  dots       = options[:dot].map { |spec| Dir[spec] }.flatten
  files      = options[:files]

  files.each do |spec|
    Dir[spec].each do |infile|
      next  if ignores.include?(infile)

      fname   = dots.include?(infile) ? ".#{infile}" : infile
      outfile = File.join(ENV['HOME'], fname)
      outdir  = File.dirname(outfile)

      # Create the folder if it doesn't exist
      unless File.directory?(outdir)
        FileUtils.mkdir_p outdir  unless options[:simulate]
        say_status :mkdir, outdir
      end

      # Delete the symlink if it exists
      if File.symlink?(outfile)
        File.unlink outfile  unless options[:simulate]
        say_status :unlink, outfile
      end

      # Do nothing if the file already exists
      if File.exists?(outfile)
        say_status :exists, outfile
        next
      end

      FileUtils.ln_s File.expand_path(infile), File.expand_path(outfile)  unless options[:simulate]
      say_status :symlink, outfile
    end
  end
end

work! options  if $0 == __FILE__
