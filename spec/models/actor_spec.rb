require 'rails_helper'

RSpec.describe Actor, :type => :model do

  describe 'validation tests' do

    let(:actor_with_last_name_nil) { described_class.new last_name: nil }
    let(:actor_with_empty_last_name) { described_class.new last_name: '' }
    let(:actor_with_min_size_last_name) { described_class.new last_name: 'A' }
    let(:actor_with_min_size_first_name) { described_class.new first_name: 'B' }
    let(:actor_with_more_then_max_size_first_name) { described_class.new first_name: 'Avakian Serhii Avakian Serhii Avakian' }
    let(:actor_with_more_then_max_size_last_name) { described_class.new last_name: 'Avakian Serhii Avakian Serhii Avakian Avakian Serhii Avakian' }

    it "is not valid without a lastname" do
      expect(actor_with_last_name_nil.valid?).to be_falsey
    end

    it "is not valid with empty lastname attribute" do
      expect(actor_with_empty_last_name.valid?).to be_falsey
    end

    it "is not valid with last name attribute less then 2" do
      expect(actor_with_min_size_last_name.valid?).to be_falsey
    end

    it "is not valid with first name attribute less then 2" do
      expect(actor_with_min_size_first_name.valid?).to be_falsey
    end

    it "is not valid with first name attribute more then 30 chars" do
      expect(actor_with_more_then_max_size_first_name.valid?).to be_falsey
    end

    it "is not valid with last name attribute more then 50 chars" do
      expect(actor_with_more_then_max_size_last_name).to_not be_valid
    end
  end

  describe "columns" do
    it{is_expected.to have_db_column(:first_name).of_type(:string)}
    it{is_expected.to have_db_column(:last_name).of_type(:string)}
  end
end


