
module RailsFriendlyUrls
  class Manager

    def self.urls
      if ActiveRecord::Base.connection.table_exists? 'my_friendly_urls'
        MyFriendlyUrl.all
      else
        []
      end
    end

    def self.each_url(&block)
      self.urls.each do |url| 
        yield url
      end
    end
  end
end
