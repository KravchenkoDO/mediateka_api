require 'rails_helper'

RSpec.describe "Posters", type: :request do

  describe "GET /index" do

    let(:posters) { create_list :poster, 5 }
    let(:poster) { posters.first }
    let(:expected_first_poster) do
      {
        id: poster.id,
        link: poster.link
      }.with_indifferent_access
    end

    before { posters }

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
      expect(JSON.parse(response.body)['posters'].first).to eq(expected_first_poster)
    end
  end
end
