require 'rails_helper'

RSpec.describe "Actors", type: :request do

  describe "GET /index" do

    let(:actors) { create_list :actor, 5 }
    let(:actor) { actors.first }
    let(:expected_first_actor) do
      {
        id: actor.id,
        first_name: actor.first_name,
        last_name: actor.last_name
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
  end
end
