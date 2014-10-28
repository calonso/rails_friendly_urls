
require 'spec_helper'

shared_examples 'a successfully injected friendly url' do
  let(:route_set) { Rails.application.routes }

  before do
    subject.urls = [url]
    subject.inject_urls ActionDispatch::Routing::Mapper.new route_set
  end

  it 'successfully injects the url' do
    route_info = Rails.application.routes.recognize_path url.slug
    route_info.delete(:controller).should == url.controller
    route_info.delete(:action).should == url.action
    route_info.should == url.defaults
  end

  it 'adds the corresponding redirection route' do
    route_info = Rails.application.routes.recognize_path url.path
    route_info[:status].should == 301
    route_info[:path].should == url.slug
  end

  it 'keeps path helpers working without changing code' do
    route_set.url_helpers.a_b_c_path.should == url.slug
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