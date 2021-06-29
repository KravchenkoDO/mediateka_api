require 'rails_helper'

RSpec.describe Company, :type => :model do

  describe 'validation tests' do

    let(:company_with_name_nil) { described_class.new name: nil }
    let(:company_with_empty_name) { described_class.new name: '' }
    let(:company_with_min_size_name) { described_class.new name: 'C' }
    let(:company_with_more_then_max_size_name) { described_class.new name: 'The HEAD Method HEAD is almost identical to GET, but without the response body.In other words, if GET /users returns a list of users, then HEAD /users will make the same request but will not return the list of users.
HEAD requests are useful for checking what a GET request will return before actually making a GET request - like before downloading a large file or response body' }

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
  end

  describe "columns" do
    it{is_expected.to have_db_column(:name).of_type(:string)}
  end
end

