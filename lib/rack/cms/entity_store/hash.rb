module Rack::Cms
  class Hash < Backend
    # This should never be used outside of tests.
    
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