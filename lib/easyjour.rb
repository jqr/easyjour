require 'net/dns/mdns-sd'

module Easyjour
  # Turns a service and protocol into _service._protocol format, automatically
  # defaults to TCP if no protocol is specified. Also gracefully handles a service
  # that is already in the _service._protocol format format.
  def self.type_from_parts(service, protocol = :tcp)
    if service =~ /^_\w+\._\w+$/
      service
    else
      "_#{service}._#{protocol}"
    end
  end
  
  # Makes a new service discoverable. Service is discoverable until stop is called.
  #
  #  # garbage_files is an HTTP server available on port 3000
  #  Easyjour.serve("garbage_files", 'http', 3000)
  def self.serve(name, service, port, text_record = {}, protocol = :tcp)
    Service.new(name, service, port, text_record, protocol = :tcp)
  end
  
  class Service
    def initialize(name, service, port, text_record = {}, protocol = :tcp)
      @service = Net::DNS::MDNSSD.register(name, Easyjour.type_from_parts(service, protocol), 'local', port, text_record)
    end
    
    # Stops a service from being discoverable.
    def stop
      @service.stop
    end
  end
  
  # Initiaites a service search, returns an Easyjour::Search. Search will continue until stop 
  # is called. Can be given a block for immediate result processing.
  #
  #  # Find the HTTP servers that respond in 5 seconds or less
  #  search = Easyjour.search('http')
  #  sleep 5
  #  search.stop
  #  search.results.each do |result|                      # access the entire result set
  #    puts "http://#{result.target}:#{result.port}/"
  #  end  
  #
  #  # Continously find HTTP servers
  #  search = Easyjour.search('http') do |result|
  #    puts "http://#{result.target}:#{result.port}/"
  #  end
  #  search.results                                       # result set is updated as servers respond
  def self.search(service, protocol = :tcp, &block)
    Search.new(service, protocol, &block)
  end

  # Searches for a service for timeout seconds and returns the results after stopping the search.
  # Can be given a block for immediate result processing.
  #
  #  # Find the Git servers that respond in 5 seconds or less
  #  results = Easyjour.search(5, 'git')
  #  results.each do |result|
  #    puts "git://#{result.target}:#{result.port}"
  #  end
  def self.synchronous_search(timeout, service, protocol = :tcp, &block)
    search = Search.new(service, protocol, &block)
    sleep timeout
    search.stop
    search.results
  end
  
  
  class Search
    def initialize(service, protocol = :tcp)
      @results = []
      @results_mutex = Mutex.new
      
      @query = Net::DNS::MDNSSD.browse(Easyjour.type_from_parts(service, protocol), 'local') do |reply|
        Net::DNS::MDNSSD.resolve(reply.name, reply.type, reply.domain) do |reply|          
          yield(reply) if block_given?

          @results_mutex.synchronize do
            @results << reply
          end
        end
      end
    end
    
    # Returns the current the results.
    def results
      @results_mutex.synchronize do
        @results
      end
    end
    
    # Stop the search.
    def stop
      @query.stop
    end
    
  end

end
