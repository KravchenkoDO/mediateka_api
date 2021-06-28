require 'rails_helper'

RSpec.describe Company, :type => :model do

  describe 'validation tests' do

    let(:company_with_name_nil) { described_class.new name: nil }
    let(:company_with_empty_name) { described_class.new name: '' }

    it "is not valid without a name" do
      expect(company_with_name_nil.valid?).to be_falsey
    end

    it "is not valid with empty name attribute" do
      expect(company_with_empty_name.valid?).to be_falsey
    end
  end
end
