require 'rails_helper'

RSpec.describe Movie, :type => :model do

  describe 'validation tests' do

    let(:movie_with_title_nil) { build :movie, title: nil }
    let(:movie_with_empty_title) { build :movie, title: '' }
    let(:movie_with_more_then_max_size_title) { build :movie, title: SecureRandom.urlsafe_base64(256) }
    let(:movie_with_empty_age_limit) { build :movie, age_limit: '' }
    let(:movie_with_more_max_size_age_limit) { build :movie, age_limit: 'PG-16-16-16' }
    let(:movie_with_more_then_max_size_description) { build :movie, description: SecureRandom.urlsafe_base64(2001) }

    it "is not valid without a title" do
      expect(movie_with_title_nil.valid?).to be_falsey
    end

    it "is not valid with empty title attribute" do
      expect(movie_with_empty_title.valid?).to be_falsey
    end

    it "is not valid with title attribute more then 255 chars" do
      expect(movie_with_more_then_max_size_title).to_not be_valid
    end

    it "is not valid with empty age_limit attribute" do
      expect(movie_with_empty_age_limit.valid?)
    end

    it "is not valid with age_limit attribute more then 10 chars" do
      expect(movie_with_more_max_size_age_limit).to_not be_valid
    end

    it "is not valid with description attribute more then 2000 chars" do
      expect(movie_with_more_then_max_size_description).to_not be_valid
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:description).of_type(:string) }
    it { is_expected.to have_db_column(:age_limit).of_type(:string) }
    it { is_expected.to have_db_column(:budget).of_type(:integer) }
    it { is_expected.to have_db_column(:box_office).of_type(:integer) }
  end
end
