require 'rails_helper'

RSpec.describe Poster, :type => :model do

  describe 'validation tests' do

    let(:poster_with_link_nil) { build :poster, link: nil }
    let(:poster_with_empty_link) { build :poster, link: '' }
    let(:poster_with_valid_link) { build :poster, link: 'https://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url' }
    let(:poster_with_invalid_link){ build :poster, link: 'htps://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url'}
    let(:expected_message) { { link: ["link not valid"] } }

    it "is not valid without a link" do
      expect(poster_with_link_nil.valid?).to be_falsey
    end

    it "is not valid with empty link attribute" do
      expect(poster_with_empty_link.valid?).to be_falsey
    end

    it "is valid link with link attribute" do
      expect(poster_with_valid_link.valid?)
    end

    it "is invalid link with link attribute" do
      expect(poster_with_invalid_link.valid?).to be_falsey
    end

    it "returns correct message with link attribute" do
      poster_with_invalid_link.save
      expect(poster_with_invalid_link.errors.messages).to eq(expected_message)
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:link).of_type(:string) }
  end
end
