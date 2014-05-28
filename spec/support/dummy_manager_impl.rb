
class DummyManagerImpl
  include RailsFriendlyUrls::Manager

  def self.urls=(urls)
    @@urls = urls
  end

  def self.each_url(&block)
    @@urls.each do |url| 
      yield url
    end
  end

end
