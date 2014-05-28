
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
      mapper = ActionDispatch::Routing::Mapper.new Rails.application.routes
      mapper.get url.path, to: mapper.redirect('/usalata') # to: "#{url.controller}##{url.action}"
      #subject.inject_urls mapper
      binding.pry
      route_info = Rails.application.routes.recognize_path url.path
      puts route_info
    end

  end

end