
class DummyFriendlyURL

  include RailsFriendlyUrls::FriendlyUrl
  
  attr_accessor :path, :slug, :controller, :action, :defaults

  def initialize(path)
    @path = path
  end

end
