require 'rack'
require 'nokogiri'
require 'active_support'

module Rack::Cms
  autoload :EntityStore,      'rack/cms/entity_store'
  autoload :Converter,        'rack/cms/converter'
  
  AVAILABLE_ATTRIBUTES = %w(ctitle ctype cunique)
  
  def self.new(app)
    Handler.new(app)
  end
  
  class Handler
    include Converter
    
    attr_accessor :store, :doc
    
    def initialize(app)
      @app = app
      self.store = EntityStore.new(:Hash)
    end
    
    def call(env)
      status, headers, body = @app.call(env)
      self.doc = Nokogiri::HTML(body)
      
      convert_doc
      
      [status, headers, doc.to_html]
    end
    
  end
  
end