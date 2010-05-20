Given /^I have the following markup:$/ do |string|
  @page_body = string
  @app = mock('Some Rack App')
  @app.stub!(:call).and_return([200, {'Content-Type' => 'text/html'}, string])
  @instance = Rack::Cms.new(@app)
end

When /^the page is rendered$/ do
  @env = Rack::MockRequest.env_for('/','HTTP_ACCEPT' => 'text/*')
  @response_body = @instance.call(@env)[2]
end

Then /^the response should be the following:$/ do |string|
  Nokogiri::HTML(@response_body).to_html.should == Nokogiri::HTML(string).to_html
end

Given /^this page's values are:$/ do |table|
  table.hashes.each do |hash|
    title, content = hash['title'], hash['content']
    @instance.store[title] = ActiveSupport::JSON.decode(content)
  end
end

Then /^the response should not have changed$/ do
  Nokogiri::HTML(@response_body).to_html.should == Nokogiri::HTML(@page_body).to_html
end
