require 'rails_helper'

RSpec.describe "Actors", type: :request do

  let(:actors) { create_list :actor, 5 }
  let(:actor) { actors.last }

  describe "GET /index" do
    let(:expected_first_actor) do
      {
        id: actor.id,
        first_name: actor.first_name,
        last_name: actor.last_name
      }.with_indifferent_access
    end
    let(:order_actor) do
      { sort_by: :first_name,
        order: :asc
      }
    end
    let(:filtering_first_name) do
      {
        first_name: actor.first_name
      }
    end
    let(:filtering_last_name) do
      {
        last_name: actor.last_name
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

    before { actors }

    it "return success" do
      get "/actors"
      expect(response).to have_http_status(:ok)
    end

    it "return correct count" do
      get "/actors"
      expect(JSON.parse(response.body)['actors'].count).to eq(5)
    end

    it "return correct key" do
      get "/actors"
      expect(JSON.parse(response.body)['actors'].first).to eq(expected_first_actor)
    end

    it "returns filtered actors first name" do
      get '/actors', params: filtering_first_name
      expect(parsed_body["actors"].length).to eq(1)
    end

    it "returns filtered actors last name" do
      get '/actors', params: filtering_last_name
      expect(parsed_body["actors"].length).to eq(1)
    end

    it "returns find actors first name" do
      get '/actors', params: filtering_first_name
      expect(parsed_body["actors"].first["first_name"]).to eq(actor.first_name)
    end

    it "returns find actor last name" do
      get '/actors', params: filtering_last_name
      expect(parsed_body["actors"].first["last_name"]).to eq(actor.last_name)
    end

    it "perform pagination" do
      get "/actors", params: pagination_page
      expect(parsed_body["actors"].count).to eq(2)
    end

    it "return pagination" do
      get "/actors", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end
  end

  # Test suite for GET /actors/:id
  describe 'GET /actors/:id' do
    before { get "/actors/#{actor.id}" }

    context 'when the record exists' do
      it 'returns the actor' do
        expect(parsed_body['id']).to eq(actor.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before { get "/actors/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /actors
  describe 'POST /actors' do
    # valid title
    let(:valid_attributes) { { first_name: 'Steven', last_name: 'Spielberg' } }

    context 'when the request is valid' do
      before { post '/actors', params: valid_attributes }

      it 'creates a actor first name' do
        expect(parsed_body['first_name']).to eq('Steven')
      end

      it 'creates a actor last name' do
        expect(parsed_body['last_name']).to eq('Spielberg')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/actors', params: { first_name: "P" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /actors/:id
  describe 'PUT /actors/:id' do
    let(:valid_attributes) { { first_name: 'Steven', last_name: 'Spielberg' } }

    context 'when the record exists' do
      before { put "/actors/#{actor.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates first name' do
        expect(actor.reload.first_name).to eq(valid_attributes[:first_name])
      end

      it 'updates last name' do
        expect(actor.reload.last_name).to eq(valid_attributes[:last_name])
      end
    end
  end

  context 'when the record does not exist' do

    before { put "/actors/100" }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
  end

  # Test suite for DELETE /producers/:id
  describe 'DELETE /actors/:id' do

    it 'returns status code 204' do
      delete "/actors/#{actor.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete "/actors/123"
      expect(response).to have_http_status(404)
    end
  end
end
