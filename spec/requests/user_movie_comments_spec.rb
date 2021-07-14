require 'rails_helper'

RSpec.describe "UserMovieComments", type: :request do

  let(:user_movie_comments) { create_list :user_movie_comment, 5 }
  let(:user_movie_comment) { user_movie_comments.last }

  describe "GET /index" do
    let(:expected_first_user_movie_comment) do
      {
        id: user_movie_comment.id,
        comment: user_movie_comment.comment,
        rating: user_movie_comment.rating
      }.with_indifferent_access
    end
    let(:order_user_movie_comment) do
      {
        sort_by: :rating,
        order: :asc
      }
    end
    let(:filtering_rating) do
      {
        rating: user_movie_comment.rating
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

    before { user_movie_comments }

    it "return success" do
      get "/user_movie_comments"
      expect(response).to have_http_status(:ok)
    end

    it "return correct count" do
      get "/user_movie_comments"
      expect(JSON.parse(response.body)['user_movie_comments'].count).to eq(5)
    end

    it "return correct key" do
      get "/user_movie_comments"
      expect(JSON.parse(response.body)['user_movie_comments'].first).to eq(expected_first_user_movie_comment)
    end

    it "returns find user_movie_comments rating" do
      get '/user_movie_comments', params: filtering_rating
      expect(parsed_body["user_movie_comments"].first["rating"]).to eq(user_movie_comment.rating)
    end

    it "perform pagination" do
      get "/user_movie_comments", params: pagination_page
      expect(parsed_body["user_movie_comments"].count).to eq(2)
    end

    it "return pagination" do
      get "/user_movie_comments", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end
  end

  # Test suite for GET /user_movie_comments/:id
  describe 'GET /user_movie_comments/:id' do
    before { get "/user_movie_comments/#{user_movie_comment.id}" }

    context 'when the record exists' do
      it 'returns the user_movie_comment' do
        expect(parsed_body['id']).to eq(user_movie_comment.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do

      before { get "/user_movie_comments/100" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /user_movie_comments
  describe 'POST /user_movie_comments' do
    # valid rating
    let(:valid_attributes) { { comment: 'good', rating: '4' } }

    context 'when the request is valid' do
      before { post '/user_movie_comments', params: valid_attributes }

      it 'creates a user_movie_comments comment' do
        expect(parsed_body['comment']).to eq('good')
      end

      it 'creates a user_movie_comments rating' do
        expect(parsed_body['rating']).to eq(4)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/user_movie_comments', params: { comment: "good", rating: "6" } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /user_movie_comments/:id
  describe 'PUT /user_movie_comments/:id' do
    let(:valid_attributes) { { comment: 'good', rating: 2 } }

    context 'when the record exists' do
      before { put "/user_movie_comments/#{user_movie_comment.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates comment' do
        expect(user_movie_comment.reload.comment).to eq(valid_attributes[:comment])
      end

      it 'updates rating' do
        expect(user_movie_comment.reload.rating).to eq(valid_attributes[:rating])
      end
    end
  end

  context 'when the record does not exist' do

    before { put "/user_movie_comments/100" }

    it 'returns status code 404' do
      expect(response).to have_http_status(404)
    end
  end

  # Test suite for DELETE /user_movie_comments/:id
  describe 'DELETE /user_movie_comments/:id' do

    it 'returns status code 204' do
      delete "/user_movie_comments/#{user_movie_comment.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete "/user_movie_comments/123"
      expect(response).to have_http_status(404)
    end
  end
end
