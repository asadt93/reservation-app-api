require 'rails_helper'
require_relative "../../shared_examples/payload_helper.rb"

RSpec.describe Api::ReservationsController, type: :controller do
  describe 'GET #post' do
    include_examples("with payload")

    context 'create with payload boo' do
      before do
        post :create, params: payload_boo
      end

      it 'response 201 success' do
          expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected recipe attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(["data", "included"])
      end
    end

    context 'create with payload foo' do
      before do
        post :create, params: payload_foo
      end
      
      it 'response 201 success' do
          expect(response).to have_http_status(:success)
      end

      it 'JSON body response contains expected recipe attributes' do
        json_response = JSON.parse(response.body)
        expect(json_response.keys).to match_array(["data", "included"])
      end
    end
  end
end
