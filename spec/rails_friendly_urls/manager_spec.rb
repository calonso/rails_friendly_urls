
shared_examples 'a successfully injected friendly url' do
  let(:route_set) { Rails.application.routes }

  before do
    subject.urls = [url]
    subject.inject_urls ActionDispatch::Routing::Mapper.new route_set
  end

  it 'successfully injects the url' do
    route_info = Rails.application.routes.recognize_path url.slug
    expect(route_info.delete(:controller)).to eq url.controller
    expect(route_info.delete(:action)).to eq url.action
    expect(route_info).to eq url.defaults
  end

  it 'adds the corresponding redirection route' do
    route_info = Rails.application.routes.recognize_path url.path
    expect(route_info[:status]).to eq 301
    expect(route_info[:path]).to eq url.slug
  end

  it 'keeps path helpers working without changing code' do
    expect(route_set.url_helpers.a_b_c_path).to eq url.slug
  end

  after do
    route_set.clear!
  end
end

describe RailsFriendlyUrls::Manager do

  describe '#inject_urls' do

    subject { RailsFriendlyUrls::Manager }

    context 'with params in the url' do
      let(:url) {
        DummyFriendlyURL.new '/a/b/c', '/friendly1', 'application', 'acti', a:1, b:2
      }

      include_examples 'a successfully injected friendly url'
    end

    context 'with no params in the url' do
      let(:url) {
        DummyFriendlyURL.new '/a/b/c', '/friendly1', 'application', 'acti', {}
      }

      include_examples 'a successfully injected friendly url'
    end
  end
end