require 'rails_helper'

RSpec.describe Company, :type => :model do

  describe 'validation tests' do

    let(:company_with_name_nil) { described_class.new name: nil }

    it "is not valid without a name" do
      expect(company_with_name_nil.valid?).to be_falsey
    end
  end
end




