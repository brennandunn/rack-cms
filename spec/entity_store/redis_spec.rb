require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Redis as an EntityStore' do
  
  subject { Rack::Cms::EntityStore.new(:Redis) }
  
  it 'should be able to set key/value pairs' do
    subject['foo'] = 'bar'
    subject['foo'].should == 'bar'
  end
  
end