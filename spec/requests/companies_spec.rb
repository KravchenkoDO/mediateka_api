# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  # initialize test data
  let(:companies) { create_list(:company, 10) }
  let(:company) { companies.first }
  let(:sorted_company) { Company.order(:name).first }
  let(:order_company) do
    {
      field_name: 'name',
      order_type: 'desc'
    }
  end
  let(:filtering_name) do
    {
      name: company.name
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
  describe 'GET /companies' do
    before { companies }

    it 'returns companies' do
      get '/companies'
      expect(parsed_body['companies'].length).to eq(10)
    end

    it 'returns companies' do
      get '/companies', params: order_company
      expect(parsed_body['companies'].last['name']).to eq(sorted_company.name)
    end

    it 'returns 1 page with 2 companies per page' do
      get '/companies', params: pagination_page
      expect(parsed_body['companies'].length).to eq(2)
    end

    it 'returns filtered companies' do
      get '/companies', params: filtering_name
      expect(parsed_body['companies'].length).to eq(1)
    end

    it "perform pagination" do
      get "/companies", params: pagination_page
      expect(parsed_body["companies"].count).to eq(2)
    end

    it "return pagination" do
      get "/companies", params: pagination_page
      expect(parsed_body).to include(expected_pagination)
    end

    it 'returns find companies' do
      get '/companies', params: filtering_name
      expect(parsed_body['companies'].first['name']).to eq(company.name)
    end

    it 'returns status code 200' do
      get '/companies'
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /companies/:id
  describe 'GET /companies/:id' do
    before { get "/companies/#{company.id}" }

    context 'when the record exists' do
      it 'returns the company' do
        expect(parsed_body['id']).to eq(company.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get '/companies/100' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for POST /companies
  describe 'POST /companies' do
    # valid title
    let(:valid_attributes) { { name: 'Paramount Pictures' } }

    context 'when the request is valid' do
      before { post '/companies', params: valid_attributes }

      it 'creates a company' do
        expect(parsed_body['name']).to eq('Paramount Pictures')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when the request is invalid' do
      before { post '/companies', params: { name: 'P' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns errors messaged' do
        expect(parsed_body['errors']).to be_instance_of(Hash)
      end
    end
  end

  # Test suite for PUT /companies/:id
  describe 'PUT /companies/:id' do
    let(:valid_attributes) { { name: 'Metro Goldwyn Mayer' } }

    context 'when the record exists' do
      before { put "/companies/#{company.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates name' do
        expect(company.reload.name).to eq(valid_attributes[:name])
      end
    end

    context 'when the record does not exist' do
      before { put '/companies/100' }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  # Test suite for DELETE /companies/:id
  describe 'DELETE /companies/:id' do
    it 'returns status code 204' do
      delete "/companies/#{company.id}"
      expect(response).to have_http_status(204)
    end

    it 'returns status code 404' do
      delete '/companies/123'
      expect(response).to have_http_status(404)
    end
  end
end
