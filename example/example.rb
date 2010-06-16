require 'sinatra/base'
require 'erb'

class ExampleApp < Sinatra::Base
  
  get '/' do
    erb :index
  end
  
end