module Rack::Cms
  module Converter
    
    MODIFY_ATTRIBUTES = %w(img)
    
    def convert_doc
      doc.xpath('.//*[@ctitle]').each do |node|
        key = node.delete('ctitle').value
        node.delete('ctype')
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
    
  end
end
