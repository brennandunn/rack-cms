require 'rack/cms/entity_store/backend'
require 'rack/cms/entity_store/hash'
require 'rack/cms/entity_store/redis'

module Rack::Cms
  
  class EntityStore
    class InvalidBackend < StandardError ; end
    
    attr_reader :backend
    
    def initialize(backend)
      @backend = fetch_backend(backend).new
    end
    
    def prefix=(prefix)
      @prefix = prefix
    end
    
    def [](key)
      if string = @backend.get(key)
        ActiveSupport::JSON.decode(string)
      end
    end
    
    def []=(key, value)
      @backend.set(key, value.to_json)
    end
    
    
    private
    
    def fetch_backend(backend)
      case backend
      when Symbol
        Rack::Cms.const_defined?(backend) ? fetch_backend(Rack::Cms.const_get(backend)) : raise(InvalidBackend)
      when Class
        backend.superclass == Backend ? backend : raise(InvalidBackend)
      end
    end
    
  end
  
end