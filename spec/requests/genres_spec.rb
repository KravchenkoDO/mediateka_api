require 'rails_helper'

RSpec.describe "Genres", type: :request do

  let(:genres) { create_list :genre, 5 }
  let(:genre) { genres.last }

  describe "GET /index" do

    let(:expected_first_genre) do
      {
        id: genre.id,
        title: genre.title
      }.with_indifferent_access
    end
    let(:filtering_title) do
      {
        title: genre.title
      }
    end
    let(:pagination_page) do
      {
        per_page: 2,
        page: 1
      }
    end

    before { genres }

    it "return success" do
      get "/genres"
      expect(response).to have_http_status(:ok)
    end

    it "return correct count" do
      get "/genres"
      expect(JSON.parse(response.body)['genres'].count).to eq(5)
    end

    it "return correct key" do
      get "/genres"
      expect(JSON.parse(response.body)['genres'].first).to eq(expected_first_genre)
    end

    it "returns filtered genres title" do
      get '/genres', params: filtering_title
      expect(parsed_body["genres"].length).to eq(1)
    end

    it "returns find genres title" do
      get '/genres', params: filtering_title
      expect(parsed_body["genres"].first["title"]).to eq(genre.title)
    end
  end

  # Test suite for GET /genres/:id
  describe 'GET /genres/:id' do
    before { get "/genres/#{genre.id}" }

    context 'when the record exists' do
      it 'returns the genre' do
        expect(parsed_body['id']).to eq(genre.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before { get "/genres/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /producers
  describe 'POST /genres' do
    # valid title
    let(:valid_attributes) { { title: 'Comedy' } }

    context 'when the request is valid' do
      before { post '/genres', params: valid_attributes }

      it 'creates a genre title' do
        expect(parsed_body['title']).to eq('Comedy')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/genres', params: { title: "nnn" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /genres/:id
  describe 'PUT /genres/:id' do
    let(:valid_attributes) { { title: 'Comedy'} }

    context 'when the record exists' do
      before { put "/genres/#{genre.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates title' do
        expect(genre.reload.title).to eq(valid_attributes[:title])
      end

      context 'when the record does not exist' do
        before { put "/genres/100" }
      end
    end
  end

  # Test suite for DELETE /genres/:id
  describe 'DELETE /genres/:id' do

    it 'returns status code 204' do
      delete "/genres/#{genre.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete "/genres/123"
      expect(response).to have_http_status(404)
    end
  end
end
