RSpec.describe(ReservationServices::External) do
  require_relative "../../shared_examples/payload_helper.rb"

  describe 'save' do
    include_examples("with payload")

    context 'with invalid params' do
      let(:instance) { described_class.new(params) }
      let(:params) { {} }

      it 'raise error' do
        expect { instance.save }.to raise_error(ReservationServices::External::NotImplementedPayload)
      end
    end

    context 'with valid params boo' do
      let(:instance) { described_class.new(params) }
      let(:params) {
        ActionController::Parameters.new(payload_boo)
      }

      it 'success? is true' do
        service = instance.save
        expect(service.success?).to be_truthy 
      end
    end

    context 'with valid params foo' do
      let(:instance) { described_class.new(params) }
      let(:params) {
        ActionController::Parameters.new(payload_foo)
      }

      it 'success? is true' do
        service = instance.save
        expect(service.success?).to be_truthy 
      end
    end

    context 'with valid duplicate reservation code' do
      before do
        create(:reservation, code: '12345')
      end
      let(:instance) { described_class.new(params) }
      let(:params) {
        ActionController::Parameters.new(payload_boo.tap{|h| h[:reservation_code] = '12345' })
      }

      it 'success? is false and return error code already taken' do
        service = instance.save
        expect(service.success?).to be_falsy
        expect(service.errors.messages.keys).to match_array([:code])
      end
    end
  end
end