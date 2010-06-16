$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'rubygems'
require 'rack'
require 'webrat'
require 'rack/test'
require 'rack/cms'
require 'spec'
require 'spec/autorun'

require 'fixtures/test_app'

Spec::Runner.configure do |config|
  
  def app
    Rack::Builder.new do
      use Rack::Cms
      run TestApp.new
    end
  end
  
end
