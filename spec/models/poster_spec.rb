require 'rails_helper'

RSpec.describe Poster, :type => :model do

  describe 'validation tests' do

    let(:poster_with_link_nil) { described_class.new link: nil }
    let(:poster_with_empty_link) { described_class.new link: '' }

    it "is not valid without a link" do
      expect(poster_with_link_nil.valid?).to be_falsey
    end

    it "is not valid with empty link attribute" do
      expect(poster_with_empty_link.valid?).to be_falsey
    end
  end
end
