
require_relative '../spec_helper'

describe RailsFriendlyUrls::Manager do

  describe 'inject urls method' do

    subject { DummyManagerImpl }

    let(:url) {
      DummyFriendlyURL.new '/a/b/c', '/friendly1', 'application', 'acti', a:1, b:2
    }

    it { should respond_to :inject_urls }

    it 'requires an each_url method implementation' do
      class <<DummyManagerImpl
        remove_method :each_url
      end      

      expect {
        subject.inject_urls(nil)
      }.to raise_error RailsFriendlyUrls::Manager::MethodNotImplementedError
    end

    describe 'url injection' do

      it 'successfully injects the url' do
        subject.urls = [url]
        subject.inject_urls ActionDispatch::Routing::Mapper.new Rails.application.routes
        route_info = Rails.application.routes.recognize_path url.slug
        route_info.delete(:controller).should == url.controller
        route_info.delete(:action).should == url.action
        route_info.should == url.defaults
      end

      it 'adds the corresponding redirection route' do
        subject.urls = [url]
        subject.inject_urls ActionDispatch::Routing::Mapper.new Rails.application.routes
        route_info = Rails.application.routes.recognize_path url.path
        puts route_info
      end

      it 'has the expected defaults'

    end
  end
end