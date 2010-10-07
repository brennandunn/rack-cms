require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Using as middleware' do
  include Rack::Test::Methods
  include Webrat::Matchers

  describe 'requests in viewing mode' do

    it 'returns clean markup' do
      get '/'
      last_response.should_not have_selector('script')
      last_response.should_not have_selector('*[ctitle]')
    end

    it 'only affects HTML responses' do
      get '/plaintext', :content_type => 'text/plain'
      last_response.should be_ok
    end

  end

  describe 'requests in editing mode' do
    before do
      set_cookie 'rack_cms_enabled=1'
    end

    it 'includes the script tag' do
      get '/'
      last_response.should have_selector('script')
    end

    it 'adds a head tag when not present and includes the script tag' do
      get '/no-head'
      last_response.should have_selector('script')
    end

    it 'successfully requests editor.js' do
      get '/__rack_cms__/editor.js'
      last_response.should be_ok
    end

  end

  describe 'updates' do

    it 'returns Not Modified if no params are sent' do
      set_cookie 'rack_cms_enabled=1'
      put '/__update__'
      last_response.status.should == 304
    end

    it 'returns OK if stored' do
      set_cookie 'rack_cms_enabled=1'
      put '/__update__', 'foo' => 'bar'
      last_response.should be_ok
    end

    it 'returns a Bad Request when not authorized' do
      put '/__update__', 'foo' => 'bar'
      last_response.status.should == 401
    end
    
  end

end
