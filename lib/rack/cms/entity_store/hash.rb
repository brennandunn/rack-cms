module Rack::Cms
  class Hash < Backend
    
    def initialize
      @store = {}
    end
    
    def set(key, value)
      @store[key] = value
    end
    
    def get(key)
      @store[key]
    end
    
  end
end