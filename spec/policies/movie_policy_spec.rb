require 'rails_helper'

RSpec.describe MoviePolicy, type: :policy do
  let(:user) { build :user }
  let(:admin) { build :user, role: 'admin' }

  subject { described_class }

  permissions :show? do
    context 'for auth user' do
      it 'grants access if user admin' do
        expect(subject).to permit(admin)
      end

      it 'grants access if user present' do
        expect(subject).to permit(user)
      end
    end

    context 'for guest' do
      let(:user) { nil }
      it { should_not permit(user) }
    end
  end
end
