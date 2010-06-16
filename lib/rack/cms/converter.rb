module Rack::Cms
  module Converter
    
    MODIFY_ATTRIBUTES = %w(img)
    
    def convert_editable_nodes
      nodes = doc.css('*[ctitle]')
      eager_load_keys(nodes.map { |n| n['ctitle'] })
      nodes.each do |node|
        key = node['ctitle']
        unless editing_mode?
          node.delete('ctitle')
          node.delete('ctype')
        end
        if MODIFY_ATTRIBUTES.include?(node.name)
          if hash = store[key]
            hash.each do |attribute_name, value|
              node[attribute_name] = value
            end
          end
        else
          node.content = store[key] if store[key].present?
        end
      end
    end
    
    def page_prefix
      doc.at_css('body')['cident'] || original_request.path_info
    end
    
    
    private
    
    # MOVE THIS TO THE ENTITY STORE TO FIGURE OUT
    def eager_load_keys(keys)
      # Speed up pulls by priming the page's placeholder keys
    end
    
  end
end
