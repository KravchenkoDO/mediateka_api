require 'rails_helper'

RSpec.describe Company, :type => :model do

  describe 'validation tests' do

    let(:company_with_name_nil) { build :company, name: nil }
    let(:company_with_empty_name) { build :company, name: '' }
    let(:company_with_min_size_name) { build :company, name: 'C' }
    let(:company_with_more_then_max_size_name) { build :company, name: SecureRandom.urlsafe_base64(256) }
    let (:company_with_valid_value) { build :company, name: 'Departed' }

    it "is not valid without a name" do
      expect(company_with_name_nil.valid?).to be_falsey
    end

    it "is not valid with empty name attribute" do
      expect(company_with_empty_name.valid?).to be_falsey
    end

    it "is not valid with name attribute less then 2" do
      expect(company_with_min_size_name.valid?).to be_falsey
    end

    it "is not valid with name attribute more then 255 chars" do
      expect(company_with_more_then_max_size_name).to_not be_valid
    end

    it "is valid with valid name attribute" do
      expect(company_with_valid_value.valid?)
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:name).of_type(:string) }
  end
end
