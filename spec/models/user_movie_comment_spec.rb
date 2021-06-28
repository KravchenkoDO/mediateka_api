require 'rails_helper'

RSpec.describe UserMovieComment, :type => :model do

  describe 'validation tests' do

    let(:user_movie_comment_with_comment_nil) { described_class.new comment: nil }
    let(:user_movie_comment_with_empty_comment) { described_class.new comment: '' }

    it "is not valid without a comment" do
      expect(user_movie_comment_with_comment_nil.valid?).to be_falsey

      it "is not valid with empty comment attribute" do
        expect(user_movie_comment_with_empty_comment.valid?).to be_falsey
      end
    end
  end
end
