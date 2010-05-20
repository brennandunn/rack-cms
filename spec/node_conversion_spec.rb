require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Converting placeholder nodes' do
  
  before(:all) do
    @rack = Rack::Cms.new(mock)
  end
  
  it 'removes the c* attributes' do
    set_doc %|<div ctitle="My node" ctype="rich"></div>|
    @converted_doc.should == '<div></div>'
  end
  
  context 'Normal block elements (like div, p, etc.)' do
    
    it 'only replaces the inner HTML' do
      @rack.store['replace_me'] = 'Replaced'
      @rack.store['and_me'] = 'Also replaced'
      set_doc %|<div ctitle="replace_me">Original</div><p class="yellow" ctitle="and_me">Another original</p>|
      @converted_doc.should == '<div>Replaced</div><p class="yellow">Also replaced</p>'
    end
    
  end
  
  context 'Image elements' do
    
    it 'sets the attributes based on the hash returned by the store' do
      @rack.store['img_replace'] = { :src => '/images/replaced.jpg', :class => 'outlined' }
      set_doc '<img ctitle="img_replace" src="/images/original.jpg">'
      @converted_doc.should == '<img src="/images/replaced.jpg" class="outlined">'
    end
    
    it 'overwrites attributes that originally existed' do
      @rack.store['img_replace'] = { :class => 'new_class' }
      set_doc '<img ctitle="img_replace" class="old_class">'
      @converted_doc.should == '<img class="new_class">'
    end
    
  end
  
  
  def set_doc(body)
    body = %|<html><body>#{body}</body></html>|
    @rack.doc = Nokogiri::HTML::DocumentFragment.parse(body)
    @rack.convert_doc
    @converted_doc = @rack.doc.to_html.gsub('<html><body>','').gsub('</body></html>','').gsub("\n",'')
  end
  
end