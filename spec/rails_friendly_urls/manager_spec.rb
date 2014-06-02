
require_relative '../spec_helper'

describe RailsFriendlyUrls::Manager do

  describe '#inject_urls' do

    subject { DummyManagerImpl }

    let(:url) {
      DummyFriendlyURL.new '/a/b/c', '/friendly1', 'application', 'acti', a:1, b:2
    }

    before do
      subject.urls = [url]
      subject.inject_urls ActionDispatch::Routing::Mapper.new Rails.application.routes
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

  end

=begin
    it 'requires an each_url method implementation' do
      class <<DummyManagerImpl
        remove_method :each_url
      end

      expect {
        subject.inject_urls(nil)
      }.to raise_error RailsFriendlyUrls::Manager::MethodNotImplementedError
    end
=end
end