require 'rails_helper'

RSpec.describe Producer, :type => :model do

  describe 'validation tests' do

    let(:producer_with_last_name_nil) { described_class.new last_name: nil }
    let(:producer_with_empty_last_name) { described_class.new last_name: '' }

    it "is not valid without a lastname" do
      expect(producer_with_last_name_nil.valid?).to be_falsey

      it "is not valid with empty lastname attribute" do
        expect(producer_with_empty_last_name.valid?).to be_falsey
      end
    end
  end
end
