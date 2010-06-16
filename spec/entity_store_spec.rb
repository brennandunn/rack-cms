require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Rack::Cms::EntityStore do

  describe 'Instantiation' do
    
    it 'requires that a backend is provided' do
      lambda { Rack::Cms::EntityStore.new }.should raise_error(ArgumentError)
    end
    
    it 'can take the backend as a symbol' do
      lambda { Rack::Cms::EntityStore.new(:Hash) }.
        should_not raise_error
    end
    
    it 'can take the backend as a class' do
      invalid_klass = Class.new {}
      lambda { Rack::Cms::EntityStore.new(invalid_klass) }.
        should raise_error(Rack::Cms::EntityStore::InvalidBackend)
      
      valid_klass = Class.new(Rack::Cms::Backend) {}
      lambda { Rack::Cms::EntityStore.new(valid_klass) }.
        should_not raise_error
    end
    
  end
  
  describe 'Reading and writing' do
    
    before { @store = Rack::Cms::EntityStore.new(:Hash) }
    
    it 'mimacks a hash object' do
      @store['foo'] = 'bar'
      @store['foo'].should == 'bar'
    end
    
    it 'always returns JSON, even though we set strings' do
      @store['json'] = { :foo => "bar" }
      @store['json'].should == { 'foo' => 'bar' }
      
      @store['string'] = 'asdf'
      @store['string'].should == 'asdf'
      
      @store['nothing'] = nil
      @store['nothing'].should == nil
    end
    
  end
  
  describe 'Prefixes' do
    
    it 'joins the prefix and key with a pipe' do
      
    end
    
  end

end
