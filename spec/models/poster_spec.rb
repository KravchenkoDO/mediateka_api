require 'rails_helper'

RSpec.describe Poster, :type => :model do

  describe 'validation tests' do

    let(:poster_with_link_nil) { build :random_link, link: nil }
    let(:poster_with_empty_link) { build :random_link, link: '' }
    let(:poster_with_valid_link) { build :random_link, link: 'https://stackoverflow.com/questions/3809401/what-is-a-good-regular-expression-to-match-a-url' }

    it "is not valid without a link" do
      expect(poster_with_link_nil.valid?).to be_falsey
    end

    it "is not valid with empty link attribute" do
      expect(poster_with_empty_link.valid?).to be_falsey
    end

    it "is valid link with link attribute" do
      expect(poster_with_valid_link.valid?)
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:link).of_type(:string) }
  end
end
