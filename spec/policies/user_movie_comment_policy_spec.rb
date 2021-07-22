require 'rails_helper'

RSpec.describe UserMovieCommentPolicy, type: :policy do
  let(:user_user) { build :user, role: 'user' }
  let(:admin_user) { build :user, role: 'admin' }

  subject { described_class }

  permissions :show? do
    context 'for auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin_user)
      end

      it 'grants access if user user' do
        expect(subject).to permit(user_user)
      end
    end

    context 'if user not present' do
      let(:user) { nil }
      it { should_not permit(user) }
    end

    context 'for guest user' do
      let(:user) { build :user, role: 'guest' }
      it { should_not permit(user) }
    end
  end

  permissions :create? do
    context 'for auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin_user)
      end

      it 'grants access if user user' do
        expect(subject).to permit(user_user)
      end
    end

    context 'if user not present' do
      let(:user) { nil }
      it { should_not permit(user) }
    end

    context 'for guest user' do
      let(:user) { build :user, role: 'guest' }
      it { should_not permit(user) }
    end
  end

  # context 'when user has user role' do
  #   let(:role) { :user }
  #
  #   it { should authorize(:create) }
  #
  #   context 'when the current user is the comment owner' do
  #     it { should authorize(:edit) }
  #     it { should authorize(:destroy) }
  #   end
  #
  #   context 'when the current user is not the comment owner' do
  #     let(:comment) { create(:user_movie_comment, user: guest) }
  #
  #     it { should_not authorize(:edit) }
  #     it { should_not authorize(:destroy) }
  #   end
  # end
  #
  # context 'when user has admin role' do
  #   let(:role) { :admin }
  #
  #   it { should_not authorize(:create) }
  #   it { should_not authorize(:edit) }
  #   it { should_not authorize(:destroy) }
  # end
end
