if Rails::VERSION::MAJOR == 4
  require 'support/routes/rails4'
else
  require 'support/routes/rails3'
end

def routes_file
  if Rails::VERSION::MAJOR == 4
    'spec/support/routes/rails4.rb'
  else
    'spec/support/routes/rails3.rb'
  end
end

def routes_contents
  if Rails::VERSION::MAJOR == 3
    <<-EOS 
RailsFriendlyUrlsApp.routes.draw do

  RailsFriendlyUrls::Manager.inject_urls self

end
    EOS
  else
    <<-EOS 
RailsFriendlyUrlsApp::Application.routes.draw do

  RailsFriendlyUrls::Manager.inject_urls self

end
    EOS
  end
end