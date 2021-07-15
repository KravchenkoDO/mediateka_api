require 'rails_helper'

RSpec.describe "Posters", type: :request do

  let(:posters) { create_list :poster, 5 }
  let(:poster) { posters.first }
  let(:expected_first_poster) do
    {
      id: poster.id,
      link: poster.link
    }.with_indifferent_access
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

  before { posters }

  describe "GET /index" do

    it "return success" do
      get "/posters"
      expect(response).to have_http_status(:ok)
    end

    it "return correct count" do
      get "/posters"
      expect(JSON.parse(response.body)['posters'].count).to eq(5)
    end

    it "return correct key" do
      get "/posters"
      expect(JSON.parse(response.body)['posters'].first).to include(expected_first_poster)
    end

    it "perform pagination" do
      get "/posters", params: pagination_page
      expect(parsed_body["posters"].count).to eq(2)
    end

    it "return pagination" do
      get "/posters", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end
  end

  # Test suite for GET /posters/:id
  describe 'GET /posters/:id' do
    before { get "/posters/#{poster.id}" }

    context 'when the record exists' do
      it 'returns the poster' do
        expect(parsed_body['id']).to eq(poster.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before { get "/posters/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /posters
  describe 'POST /posters' do
    # valid title
    let(:valid_attributes) { { link: 'https://app.diagrams.net/#G1R_DjLkvHnxF_3VINdkspUVAcmmqNWfCB' } }

    context 'when the request is valid' do
      before { post '/posters', params: valid_attributes }

      it 'creates a poster' do
        expect(parsed_body['link']).to eq('https://app.diagrams.net/#G1R_DjLkvHnxF_3VINdkspUVAcmmqNWfCB')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/posters', params: { link: 'app' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /posters/:id
  describe 'PUT /posters/:id' do
    let(:valid_attributes) { { link: 'https://app.diagrams.net/#G1R_DjLkvHnxF_3VINdkspUVAcmmqNWfCB' } }

    context 'when the record exists' do
      before { put "/posters/#{poster.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates name' do
        expect(poster.reload.link).to eq(valid_attributes[:link])
      end
    end

    context 'when the record does not exist' do

      before { put "/posters/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for DELETE /companies/:id
  describe 'DELETE /posters/:id' do

    it 'returns status code 204' do
      delete "/posters/#{poster.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete "/posters/123"
      expect(response).to have_http_status(404)
    end
  end
end
