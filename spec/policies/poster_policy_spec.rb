require 'rails_helper'

RSpec.describe PosterPolicy, type: :policy do
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

  permissions :create?, :update?, :destroy? do
    context 'for auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin_user)
      end

      it 'grants access if user user' do
        expect(subject).to_not permit(user_user)
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
end
