require "rails_helper"

RSpec.describe Genre, :type => :model do

  describe 'validation tests' do
    let(:genre_with_title_nil) { described_class.new title: nil }
    let(:genre_with_empty_title) { described_class.new title: '' }
    let(:genre_with_min_size_title) { described_class.new title: 'Dram' }
    let(:genre_with_min_size_title) { described_class.new title: 'Western Shoot ‘Em Up Action + Western Shoot ‘Em Up Action ' }
    let(:genre_with_valid_title) { described_class.new title: 'Thriller' }
    let(:genre_with_same_title) { described_class.new title: 'action' }
    let(:genre_without_only_letters_title) { described_class.new title: 'Action2' }

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

      expect(genre_with_min_size_title).to_not be_valid
    end

    it "is valid with valid title attribute" do
      expect(genre_with_valid_title).to be_valid
    end

    before { described_class.create!(title: 'Action') }
    it "is not valid with the same title attribute" do
      expect(genre_with_same_title).to_not be_valid
    end

    it "is valid title with only letters" do
      expect(genre_without_only_letters_title).to_not be_valid
    end
  end

end
