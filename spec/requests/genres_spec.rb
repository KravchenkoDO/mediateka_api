require 'rails_helper'

RSpec.describe "Genres", type: :request do

  describe "GET /index" do

    let(:genres) { create_list :genre, 5 }
    let(:genre) { genres.first }
    let(:expected_first_genre) do
      {
        id: genre.id,
        title: genre.title
      }.with_indifferent_access
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
  end
end
