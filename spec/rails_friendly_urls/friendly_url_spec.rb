
describe RailsFriendlyUrls::FriendlyUrl do

  describe '#set_destination_data' do

    let(:path) { '/test' }
    let(:controller) { 'application' }
    let(:action) { 'index' }

    before do
      mapper = ActionDispatch::Routing::Mapper.new Rails.application.routes
      mapper.get path, to: "#{controller}##{action}"
      subject.set_destination_data
    end

    subject { DummyFriendlyURL.new path }

    it 'successfully assigns controller' do
      subject.controller.should == controller
    end

    it 'successfully assigns action' do
      subject.action.should == action
    end

    describe 'defaults' do

      context 'with no parameters' do
        it 'works with no parameters' do
          subject.defaults.should == {}
        end
      end

      context 'using parameters in url' do

        let(:path) { '/:lang/test' }

        subject { DummyFriendlyURL.new '/es-ES/test' }

        it 'successfully assigns defaults' do
          subject.defaults.should == { lang: 'es-ES' }
        end

      end

      context 'using parameters in query string' do
        it 'successfully assigns defaults'
      end

    end

  end
end
