
describe RailsFriendlyUrls::FriendlyUrl do

  describe '#set_destination_data' do

    let(:path) { '/test' }
    let(:controller) { 'application' }
    let(:action) { 'index' }

    before do
      mapper = ActionDispatch::Routing::Mapper.new Rails.application.routes
      mapper.get path, to: "#{controller}##{action}"
    end 

    subject { DummyFriendlyURL.new path }

    it 'successfully assigns controller' do
      expect(subject.controller).to eq controller
    end

    it 'successfully assigns action' do
      expect(subject.action).to eq action
    end

    describe 'defaults' do

      context 'with no parameters' do
        it 'works with no parameters' do
          expect(subject.defaults).to eq({})
        end
      end

      context 'using parameters in url' do

        let(:path) { '/:lang/test' }

        subject { DummyFriendlyURL.new '/es-ES/test' }

        it 'successfully assigns defaults' do
          expect(subject.defaults).to eq lang: 'es-ES'
        end
      end

      context 'using parameters in query string' do
        subject { DummyFriendlyURL.new '/test?lang=es-ES' }

        it 'successfully assigns defaults' do
          expect(subject.defaults).to eq lang: 'es-ES'
        end
      end
    end
  end
end