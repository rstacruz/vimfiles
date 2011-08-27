input = File.read(ARGV[0])

snippets = Hash.new
current  = nil

def convert(str)
  if str =~ /^(.*)\$\{[0-9]\}$/
    str = $1 + "$0"
  end

  if ENV['SASSIFY']
    str = str.gsub(';', '')
    str = str.gsub('@include ', '+')
    str = str.gsub(' {', '')
    str = str.gsub(/^}/, '')
  end

  str
end

input.split("\n").each do |line|
  if line =~ /^snippet (.*)$/
    current = $1
  else
    l = line.match(/^\t?(.*)$/) && $1
    l = convert(l)

    if snippets[current].nil?
      snippets[current] = l
    else
      snippets[current] += "\n#{l}"
    end
  end
end

def out(str)
  $stdout.write "#{str}\n"
end

out "# Auto-converted"

snippets.each { |name, value|
  out ""
  out "snippet #{name} \"#{name}\""
  out value
  out "endsnippet"
}
