require 'rubygems'
require 'example'

$LOAD_PATH.unshift File.dirname(File.dirname(__FILE__)) + '/../lib'
require 'rack/cms'

use Rack::Cms
run ExampleApp