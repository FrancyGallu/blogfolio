# ContentURLsManager
#
# Usage: content_urls = ContentURLsManager.string_content_urls(contents)
#        contents = ContentURLsManager.json_content_urls(content_urls)
class ContentURLsManager
  def self.json_content_urls(content_urls)
    # This method converts a content_urls in string format into a contents in json format
    # * *Args* :
    #   - +content_urls+ -> a multiline string, representing the content_urls
    # * *Returns* :
    #   - the content_urls formatted into an array of hashes
    contents = []
    content_urls.to_s.each_line do |line|
      url, caption = line.sub!(/\s/, '').chomp.split(',')
      contents << {
          url: url,
          caption: caption
      }
    end unless content_urls.nil?
    return contents
  end

  def self.string_content_urls(contents)
    # This method converts a contents in json format into a content_urls in string format
    # * *Args* :
    #   - +contents+ -> an array of hashes, representing the content_urls
    # * *Returns* :
    #   - the content_urls formatted into a multiline string
    content_urls = ''

    contents.each_with_index do |content, index|
      if index == contents.length - 1
        content.each_key do |key|
          if key == :caption
            content_urls = content_urls << remove_nil_key(content[key])
          elsif key == :url
            content_urls = content_urls << remove_nil_key(content[key])<< ", "
          end
        end
      else
        content.each_key do |key|
          if key == :caption
            content_urls = content_urls << remove_nil_key(content[key]) << "\n"
          elsif key == :url
            content_urls = content_urls << remove_nil_key(content[key]) << ", "
          end
        end
      end
    end

    return content_urls
  end

  def self.remove_nil_key(value)
    value.nil? ? '' : value
  end
end
