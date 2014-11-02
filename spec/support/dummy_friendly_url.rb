
class DummyFriendlyURL
  
  include RailsFriendlyUrls::FriendlyUrl

  attr_accessor :path, :slug, :controller, :action, :defaults

  def initialize(path, slug = nil, controller = nil, action = nil, defaults = nil)
    @path = path
    if slug
      @slug = slug
      @controller = controller
      @action = action
      @defaults = defaults
    else
      set_destination_data!
    end
  end
end
