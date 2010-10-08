require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Configuring rack-cms' do
  
  context 'applying a password' do
    
    it 'is in editing mode when password matches' do
      cms = Rack::Cms.new(TestApp.new, :password => 'password')
      cms.call Rack::MockRequest.env_for('/', 'HTTP_COOKIE' => 'rack_cms_enabled=password')
      cms.editing_mode?.should be_true
    end
    
    it 'is not in editing mode if the password does not match' do
      cms = Rack::Cms.new(TestApp.new, :password => 'password')
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