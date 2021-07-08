require "rails_helper"

RSpec.describe Genre, :type => :model do

  describe 'validation tests' do
    let(:genre_with_title_nil) { build :genre, title: nil }
    let(:genre_with_empty_title) { build :genre, title: '' }
    let(:genre_with_min_size_title) { build :genre, title: 'Dram' }
    let(:genre_with_more_then_max_size_title) { build :genre, title: SecureRandom.urlsafe_base64(51) }
    let(:genre_with_valid_title) { build :genre, title: 'Thriller' }
    let(:genre_with_same_title) { build :genre, title: 'action' }

    it "is not valid without a title" do
      expect(genre_with_title_nil.valid?).to be_falsey
    end

    it "is not valid with empty title attribute" do
      expect(genre_with_empty_title.valid?).to be_falsey
    end

    it "is not valid with title attribute less then 5" do
      expect(genre_with_min_size_title.valid?).to be_falsey
    end

    it "is not valid with title attribute more then 50 chars" do
      expect(genre_with_more_then_max_size_title).to_not be_valid
    end

    it "is valid with valid title attribute" do
      expect(genre_with_valid_title).to be_valid
    end

    before { described_class.create!(title: 'Action') }
    it "is not valid with the same title attribute" do
      expect(genre_with_same_title).to_not be_valid
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:title).of_type(:string) }
  end
end
