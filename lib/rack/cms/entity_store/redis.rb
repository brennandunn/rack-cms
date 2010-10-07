module Rack::Cms
  class Redis < Backend
    
    def initialize
      require 'redis'
      @store = ::Redis.new
    end
    
    def set(key, value)
      @store.set key, value
    end
    
    def get(key)
      @store.get key
    end
    
  end
end