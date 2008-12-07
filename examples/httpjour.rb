#!/usr/bin/env ruby
require 'rubygems'
require 'easyjour'

class HTTPjour
  def self.serve
    # This code is webrick example code, slightly modified
    require 'webrick'
    include WEBrick

    port = rand(10_000) + 1025
    s = HTTPServer.new(
      :Port            => port,
      :DocumentRoot    => Dir::pwd
    )
    Easyjour.serve("webrick-#{port}", 'http', port)

    trap("INT") { s.shutdown }
    s.start
  end


  def self.search(open = false)
    puts "Searching for servers... (press control-c to stop)\n\n"
    search = Easyjour.search('http') do |service|
      puts " * http://#{service.target}:#{service.port}/"
      system('open', "http://#{service.target}:#{service.port}/") if open
    end
    trap("INT") { exit }
    loop { sleep 10 }
  end
  

  def self.help
    puts "usage: "
    puts " serve    # serves the current directory over HTTP"
    puts " search   # looks for HTTP servers"
    puts " show     # opens every HTTP server as it finds them"
    exit
  end
end

case ARGV[0]
when 'serve'
  HTTPjour.serve
when 'search'
  HTTPjour.search
when 'open'
  HTTPjour.search(true)
else
  HTTPjour.help
end
