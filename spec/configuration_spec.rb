require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Configuring rack-cms' do
  
  context 'applying a password' do
    
    it 'is in editing mode when password matches' do
      cms = Rack::Cms.new(TestApp.new, :password => 'example')
      cms.call Rack::MockRequest.env_for('/', 'HTTP_COOKIE' => 'rack_cms_enabled=c3499c2729730a7f807efb8676a92dcb6f8a3f8f')
      cms.editing_mode?.should be_true
    end
    
    it 'is not in editing mode if the password does not match' do
      cms = Rack::Cms.new(TestApp.new, :password => 'example')
      cms.call Rack::MockRequest.env_for('/', 'HTTP_COOKIE' => 'rack_cms_enabled=fake')
      cms.editing_mode?.should be_false
    end
    
  end
  
  it 'defaults to using Redis as the entity store' do
    cms = Rack::Cms.new(TestApp.new)
    cms.store.backend.should be_an_instance_of Rack::Cms::Redis
  end
  
  it 'can use an alternate entity store if supplied' do
    cms = Rack::Cms.new(TestApp.new, :entity_store => :Hash)
    cms.store.backend.should be_an_instance_of Rack::Cms::Hash
  end
  
end