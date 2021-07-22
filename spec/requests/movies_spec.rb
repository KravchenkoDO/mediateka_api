require 'rails_helper'

RSpec.describe "Movies", type: :request do

  let(:movies) { create_list :movie, 5 }
  let(:movie) { movies.last }

  describe "GET /index" do
    let(:expected_first_movie) do
      {
        id: movie.id,
        title: movie.title,
        description: movie.description,
        age_limit: movie.age_limit,
        budget: movie.budget,
        box_office: movie.box_office
      }.with_indifferent_access
    end
    let(:order_movie) do
      { sort_by: :title,
        order: :asc
      }
    end
    let(:filtering_title) do
      {
        title: movie.title
      }
    end
    let(:filtering_age_limit) do
      {
        age_limit: movie.age_limit
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
    before { movies }

    it "return success" do
      get "/movies"
      expect(response).to have_http_status(:ok)
    end

    it "return correct count" do
      get "/movies"
      expect(JSON.parse(response.body)['movies'].count).to eq(5)
    end

    it "return correct key" do
      get "/movies"
      expect(JSON.parse(response.body)['movies'].first).to eq(expected_first_movie)
    end

    it "returns filtered movies title" do
      get '/movies', params: filtering_title
      expect(parsed_body["movies"].length).to eq(1)
    end

    it "returns filtered movies age limit" do
      get '/movies', params: filtering_age_limit
      expect(parsed_body["movies"].length).to eq(1)
    end

    it "returns find movie title" do
      get '/movies', params: filtering_title
      expect(parsed_body["movies"].first["title"]).to eq(movie.title)
    end

    it "returns find movie age limit" do
      get '/movies', params: filtering_age_limit
      expect(parsed_body["movies"].first["age_limit"]).to eq(movie.age_limit)
    end

    it "perform pagination" do
      get "/movies", params: pagination_page
      expect(parsed_body["movies"].count).to eq(2)
    end

    it "return pagination" do
      get "/movies", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end
  end

  # Test suite for GET /movies/:id
  describe 'GET /movies/:id' do
    before { get "/movies/#{movie.id}" }

    context 'when the record exists' do
      it 'returns the movie' do
        expect(parsed_body['id']).to eq(movie.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before { get "/movies/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /movies
  describe 'POST /movies' do
    # valid title
    let(:poster) { create :poster }
    let(:valid_attributes) { { title: '21', description: 'Good film', poster_id: poster.id, age_limit: 'PG-17', budget: '2000000', box_office: '3500000' } }

    context 'when the request is valid' do
      before { post '/movies', params: valid_attributes }

      it 'creates a movie title' do
        expect(parsed_body['title']).to eq('21')
      end

      it 'creates a movie description' do
        expect(parsed_body['description']).to eq('Good film')
      end

      it 'creates a movie age_limit' do
        expect(parsed_body['age_limit']).to eq('PG-17')
      end

      it 'creates a movie budget' do
        expect(parsed_body['budget']).to eq(2000000)
      end

      it 'creates a movie box_office' do
        expect(parsed_body['box_office']).to eq(3500000)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/movies', params: { description: "P" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /movies/:id
  describe 'PUT /movies/:id' do
    let(:valid_attributes) { { title: '21', description: 'Good film', age_limit: 'PG-17', budget: '2000000', box_office: '3500000' } }

    context 'when the record exists' do
      before { put "/movies/#{movie.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates title' do
        expect(movie.reload.title).to eq(valid_attributes[:title])
      end

      it 'updates description' do
        expect(movie.reload.description).to eq(valid_attributes[:description])
      end
    end
  end

  context 'when the record does not exist' do

    before { put "/movies/100" }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
  end

  # Test suite for DELETE /movies/:id
  describe 'DELETE /movies/:id' do

    it 'returns status code 204' do
      delete "/movies/#{movie.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete "/movies/123"
      expect(response).to have_http_status(404)
    end
  end
end
