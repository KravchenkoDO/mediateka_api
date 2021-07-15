require 'rails_helper'

RSpec.describe "Producers", type: :request do
  include RequestSpecHelper
  let(:producers) { create_list :producer, 5 }
  let(:producer) { producers.last }

  describe "GET /index" do

    let(:expected_first_producer) do
      { id: producer.id,
        first_name: producer.first_name,
        last_name: producer.last_name,
      }.with_indifferent_access
    end
    let(:order_producer) do
      { sort_by: :first_name,
        order: :asc
      }
    end
    let(:filtering_first_name) do
      {
        first_name: producer.first_name
      }
    end
    let(:filtering_last_name) do
      {
        last_name: producer.last_name
      }
    end
    let(:pagination_page) do
      {
        per_page: 2,
        page: 1
      }
    end
    let(:expected_pagination) do
      {
        total_pages: 3,
        current_page: 1
      }.with_indifferent_access
    end

    before { producers }

    it "return success" do
      get "/producers"
      expect(response).to have_http_status(:ok)
    end

    it "return correct count" do
      get "/producers"
      expect(JSON.parse(response.body)['producers'].count).to eq(5)
    end

    it "returns filtered producers first name" do
      get '/producers', params: filtering_first_name
      expect(parsed_body["producers"].length).to eq(1)
    end

    it "returns filtered producers last name" do
      get '/producers', params: filtering_last_name
      expect(parsed_body["producers"].length).to eq(1)
    end

    it "returns find producer first name" do
      get '/producers', params: filtering_first_name
      expect(parsed_body["producers"].first["first_name"]).to eq(producer.first_name)
    end

    it "returns find producer last name" do
      get '/producers', params: filtering_last_name
      expect(parsed_body["producers"].first["last_name"]).to eq(producer.last_name)
    end

    it "return correct key" do
      get "/producers"
      expect(JSON.parse(response.body)['producers'].first).to include(expected_first_producer)
    end

    it "perform pagination" do
      get "/producers", params: pagination_page
      expect(parsed_body["producers"].count).to eq(2)
    end

    it "return pagination" do
      get "/producers", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end

    # Test suite for GET /producers/:id
    describe 'GET /producers/:id' do
      before { get "/producers/#{producer.id}" }

      context 'when the record exists' do
        it 'returns the producer' do
          expect(parsed_body['id']).to eq(producer.id)
        end

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end
      end

      context 'when the record does not exist' do

        before { get "/producers/100" }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end
      end
    end

    # Test suite for POST /producers
    describe 'POST /producers' do
      # valid title
      let(:valid_attributes) { { first_name: 'Steven', last_name: 'Spielberg' } }

      context 'when the request is valid' do
        before { post '/producers', params: valid_attributes }

        it 'creates a producer first name' do
          expect(parsed_body['first_name']).to eq('Steven')
        end

        it 'creates a producer last name' do
          expect(parsed_body['last_name']).to eq('Spielberg')
        end

        it 'returns status code 201' do
          expect(response).to have_http_status(:created)
        end
      end

      context 'when the request is invalid' do
        before { post '/producers', params: { first_name: "P" } }

        it 'returns status code 422' do
          expect(response).to have_http_status(422)
        end

        it 'returns errors messaged' do
          expect(parsed_body['errors']).to be_instance_of(Hash)
        end
      end
    end

    # Test suite for PUT /producers/:id
    describe 'PUT /producers/:id' do
      let(:valid_attributes) { { first_name: 'Steven', last_name: 'Spielberg' } }

      context 'when the record exists' do
        before { put "/producers/#{producer.id}", params: valid_attributes }

        it 'updates the record' do
          expect(response.body).to be_empty
        end

        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end

        it 'updates first name' do
          expect(producer.reload.first_name).to eq(valid_attributes[:first_name])
        end

        it 'updates last name' do
          expect(producer.reload.last_name).to eq(valid_attributes[:last_name])
        end
      end
    end

    context 'when the record does not exist' do

      before { put "/producers/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for DELETE /producers/:id
  describe 'DELETE /producers/:id' do

    it 'returns status code 204' do
      delete "/producers/#{producer.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete "/producers/123"
      expect(response).to have_http_status(404)
    end
  end
end
