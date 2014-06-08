
describe RailsFriendlyUrls::Manager do

  describe '#inject_urls' do

    subject { DummyManagerImpl }

    let(:url) {
      DummyFriendlyURL.new '/a/b/c', '/friendly1', 'application', 'acti', a:1, b:2
    }

    let(:route_set) { Rails.application.routes }

    before do
      subject.urls = [url]
      subject.inject_urls ActionDispatch::Routing::Mapper.new route_set
    end

    it 'successfully injects the url' do
      route_info = route_set.recognize_path url.slug
      route_info[:controller].should == url.controller
      route_info[:action].should == url.action
      route_info.should == url.defaults
    end

    it 'adds the corresponding redirection route' do
      route_info = route_set.recognize_path url.path
      route_info[:status].should == 301
      route_info[:path].should == url.slug
    end

    it 'keeps path helpers working without changing code' do
      route_set.url_helpers.a_b_c_path.should == url.slug
    end
  end
end
