Given /^I am in editing mode$/ do
  @cookies = 'rack_cms_enabled=1'
end

When /^the placeholder "([^\"]*)" is saved with "([^\"]*)"$/ do |placeholder, content|
  @env = Rack::MockRequest.env_for('/__update__', :method => 'PUT', :params => { placeholder => ActiveSupport::JSON.decode(content) }, 'HTTP_ACCEPT' => 'text/*', 'HTTP_COOKIE' => @cookies)
  @response_body = @instance.call(@env)[2]
end