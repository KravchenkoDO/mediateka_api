require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # initialize test data
  let(:users) { create_list(:user, 10) }
  let(:user) { users.first }
  let(:sorted_user) { User.order(:first_name).first }
  let(:order_user) do
    {
      field_name: 'first_name',
      order_type: 'desc'
    }
  end
  let(:filtering_name) do
    {
      first_name: user.first_name
    }
  end
  let(:pagination_page) do
    {
      page: 1,
      per_page: 2
    }
  end
  let(:expected_pagination) do
    {
      total_pages: 5,
      current_page: 1
    }.with_indifferent_access
  end

  # Test suite for GET /companies
  describe 'GET /users' do
    before { users }

    it 'returns users' do
      get '/users'
      expect(parsed_body['users'].length).to eq(10)
    end

    it 'returns users' do
      get '/users', params: order_user
      expect(parsed_body['users'].last['first_name']).to eq(sorted_user.first_name)
    end

    it 'returns 1 page with 2 users per page' do
      get '/users', params: pagination_page
      expect(parsed_body['users'].length).to eq(2)
    end

    it 'returns filtered users' do
      get '/users', params: filtering_name
      expect(parsed_body['users'].length).to eq(1)
    end

    it 'returns find users' do
      get '/users', params: filtering_name
      expect(parsed_body['users'].first['first_name']).to eq(user.first_name)
    end

    it 'returns status code 200' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    it "perform pagination" do
      get "/users", params: pagination_page
      expect(parsed_body["users"].count).to eq(2)
    end

    it "return pagination" do
      get "/users", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end
  end

  # Test suite for GET /users/:id
  describe 'GET /users/:id' do
    before { get "/users/#{user.id}" }

    context 'when the record exists' do
      it 'returns the user' do
        expect(parsed_body['id']).to eq(user.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get '/users/abc' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /users
  describe 'POST /users' do
    # valid parameters
    let(:valid_attributes) { { first_name: 'Dmitry', last_name: 'Kravchenko', role: 'guest',
                               email: 'kravchenkodmo@gmail.com', password: '123qaz', nickname: 'Demon4eg' } }.as_json

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(parsed_body['first_name']).to eq('Dmitry')
      end

      it 'creates a user' do
        expect(parsed_body['last_name']).to eq('Kravchenko')
      end

      it 'creates a user' do
        expect(parsed_body['nickname']).to eq('Demon4eg')
      end

      it 'creates a user' do
        expect(parsed_body['email']).to eq('kravchenkodmo@gmail.com')
      end

      it 'creates a user' do
        expect(parsed_body['password']).to eq('123qaz')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { name: 'P' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /companies/:id
  describe 'PUT /users/:id' do
    let(:valid_attributes) { { first_name: 'Dmitry', last_name: 'Kravchenko', role: 'guest',
                               email: 'kravchenkodmo@gmail.com', password: '123qaz', nickname: 'Demon4eg' } }

    context 'when the record exists' do
      before { put "/users/#{user.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates last_name' do
        expect(user.reload.last_name).to eq(valid_attributes[:last_name])
      end
    end

    context 'when the record does not exist' do
      before { put '/users/100' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for DELETE /companies/:id
  describe 'DELETE /users/:id' do
    it 'returns status code 204' do
      delete "/users/#{user.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete '/users/123'
      expect(response).to have_http_status(404)
    end
  end
end
