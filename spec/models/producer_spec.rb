require 'rails_helper'

RSpec.describe Producer, :type => :model do

  describe 'validation tests' do

    let(:producer_with_last_name_nil) { build :producer, last_name: nil }
    let(:producer_with_empty_last_name) { build :producer, last_name: '' }
    let(:producer_with_min_size_first_name) { build :producer, first_name: 'A' }
    let(:producer_with_min_size_last_name) { build :producer, last_name: 'B' }
    let(:producer_with_more_then_max_size_first_name) { build :producer, first_name: SecureRandom.urlsafe_base64(31) }
    let(:producer_with_more_then_max_size_last_name) { build :producer, last_name: SecureRandom.urlsafe_base64(51) }

    it "is not valid without a last name" do
      expect(producer_with_last_name_nil.valid?).to be_falsey
    end

    it "is not valid with empty last name attribute" do
      expect(producer_with_empty_last_name.valid?).to be_falsey
    end

    it "is not valid with first name attribute less then 2" do
      expect(producer_with_min_size_first_name.valid?).to be_falsey
    end

    it "is not valid with last name attribute less then 2" do
      expect(producer_with_min_size_last_name.valid?).to be_falsey
    end

    it "is not valid with firs name attribute more then 30 chars" do
      expect(producer_with_more_then_max_size_first_name).to_not be_valid
    end

    it "is not valid with last name attribute more then 50 chars" do
      expect(producer_with_more_then_max_size_last_name).to_not be_valid
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:first_name).of_type(:string) }
    it { is_expected.to have_db_column(:last_name).of_type(:string) }
  end

  describe "associations" do
    it { should have_and_belong_to_many(:movies).join_table('movie_producers') }
  end
end
