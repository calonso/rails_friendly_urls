
require_relative '../spec_helper'

describe RailsFriendlyUrls::Manager do

  describe 'inject urls method' do

    subject { DummyManagerImpl }

    it { should respond_to :inject_urls }

    it 'requires each_url implementation' do
      class <<DummyManagerImpl
        remove_method :each_url
      end      

      expect {
        subject.inject_urls(nil)
      }.to raise_error RailsFriendlyUrls::Manager::MethodNotImplementedError
    end

    

  end

end