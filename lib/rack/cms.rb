require 'rack'
require 'nokogiri'
require 'active_support'
require 'active_support/json'

module Rack::Cms
  autoload :EntityStore,      'rack/cms/entity_store'
  autoload :Converter,        'rack/cms/converter'
  autoload :Editor,           'rack/cms/editor'

  AVAILABLE_ATTRIBUTES = %w(ctitle ctype cunique)

  def self.new(app)
    Handler.new(app)
  end

  class Handler
    include Converter, Editor

    PUBLIC_DIRECTORY = '/__rack_cms__'
    MIME_TYPES = ['text/html', 'application/xhtml+xml']


    attr_accessor :original_request, :store, :doc

    def initialize(app)
      @app = Rack::Static.new(app, :urls => [PUBLIC_DIRECTORY], :root => public_path)
      self.store = EntityStore.new(:Redis)
    end

    def call(env)
      @env = env
      self.original_request = Rack::Request.new(env)


      return @app.call(env) if original_request.path_info =~ /^#{PUBLIC_DIRECTORY}/

      updating? ? store_placeholder : process_document
    end

    def public_path
      ::File.expand_path(::File.dirname(__FILE__) + '/cms/public')
    end


    private

      def store_placeholder
        if editing_mode?
          if key = original_request.params.keys.first
            store[key] = original_request.params[key]
            status = 200
          else
            status = 304
          end
        else
          status = 401
        end
        [status, { 'Content-Type' => 'text/html' }, []]
      end

      def process_document
        status, headers, body = @app.call(@env)
        @response = Rack::Response.new(body, status, headers)
        
        return @response.to_a unless modify?
        
        self.doc = Nokogiri::HTML([body].flatten.first)

        inject_toolbar if editing_mode?
        convert_editable_nodes

        Rack::Response.new(doc.to_html, status, headers).finish
      end

      def modify?
        @response.ok? && MIME_TYPES.include?(@response.content_type.split(";").first)
      end

      def updating?
        original_request.path_info =~ /__update__$/
      end

      def editing_mode?
        return false unless original_request
        original_request.cookies['rack_cms_enabled']
      end

  end

end
