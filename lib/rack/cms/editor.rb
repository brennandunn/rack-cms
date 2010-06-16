module Rack::Cms
  module Editor
    
    def inject_toolbar
      inject_scripts
      
      body_tag = doc.at_css 'body'
      markup = '<div id="rack_cms_toolbar"></div>'
      
      nodes = Nokogiri::HTML::DocumentFragment.parse(markup)
      body_tag.add_child(nodes)
    end
    
    def inject_scripts
      head_tag = doc.at_css 'head'
      unless head_tag
        head_tag = Nokogiri::XML::Node.new 'head', doc
        doc.at_css('html').add_next_sibling(head_tag)
      end
      
      markup = <<-HTML
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
        <script type="text/javascript" src="/__rack_cms__/editor.js"></script>
        <link type="text/css" rel="stylesheet" href="/__rack_cms__/editor.css" />
      HTML
      
      dependencies = Nokogiri::HTML::DocumentFragment.parse(markup)
      head_tag.add_child(dependencies)
    end
    
  end
end