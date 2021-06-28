require 'rails_helper'

RSpec.describe Movie, :type => :model do

  describe 'validation tests' do

    let(:movie_with_title_nil) { described_class.new title: nil }
    let(:movie_with_empty_title) { described_class.new title: '' }

    it "is not valid without a title" do
      expect(movie_with_title_nil.valid?).to be_falsey
    end

    it "is not valid with empty title attribute" do
      expect(movie_with_empty_title.valid?).to be_falsey
    end
  end
end
