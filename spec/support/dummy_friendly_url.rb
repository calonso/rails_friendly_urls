
class DummyFriendlyURL
  
  attr_accessor :path, :slug, :controller, :action, :defaults

  def initialize(path, slug, controller, action, defaults)
    @path = path
    @slug = slug
    @controller = controller
    @action = action
    @defaults = defaults
  end

end
