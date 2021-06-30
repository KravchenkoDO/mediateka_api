require 'rails_helper'

RSpec.describe UserMovieComment, :type => :model do

  describe 'validation tests' do

    let(:user_movie_comment_with_comment_nil) { build :user_movie_comment, comment: nil }
    let(:user_movie_comment_with_empty_comment) { build :user_movie_comment, comment: '' }
    let(:user_movie_comment_with_more_then_max_size_comment) { build :user_movie_comment, comment: SecureRandom.urlsafe_base64(2001) }

    it "is not valid without a comment" do
      expect(user_movie_comment_with_comment_nil.valid?).to be_falsey
    end

    it "is not valid with empty comment attribute" do
      expect(user_movie_comment_with_empty_comment.valid?).to be_falsey
    end

    it "is not valid with title attribute more then 2000 chars" do
      expect(user_movie_comment_with_more_then_max_size_comment).to_not be_valid
    end
  end

  describe "columns" do
    it { is_expected.to have_db_column(:comment).of_type(:string) }
  end
end
