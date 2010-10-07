$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'rack/cms'

require 'spec/expectations'
require 'spec/stubs/cucumber'

Before do
  require 'redis'
  Redis.new.flushall
end